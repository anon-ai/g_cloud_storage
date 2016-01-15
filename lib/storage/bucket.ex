defmodule GCloudStorage.Bucket do
   use Pipe

   defstruct [
     :kind, :id, :selfLink, :projectNumber, :name,
     :time_created, :updated, :metageneration, :owner,
     :location, :storageClass, :etag
   ]

   alias GCloudStorage.Client

   @doc """
   Retrieve list of buckets for the given project
   """
   @spec list(String.t, map) :: tuple
   def list(project, opts \\ %{}) do
     params = Map.put_new opts, :project, project

     pipe_matching {:ok, _}, GCloudStorage.Client.get("", [], params: params)
     |> extract_body
     |> fill_buckets
   end

   @doc """
   Insert new bucket
   """
   @spec insert(String.t, map) :: tuple
   def insert(project, params = %GCloudStorage.BucketParams{}) do
     payload = Poison.encode!(params)

     request =
       GCloudStorage.Client.post("?project=#{project}", payload)
       |> extract_body
     case request do
       {:ok, params} -> {:ok, new_bucket(params)}
       error -> error
     end
   end

   @doc """
   Remove bucket
   """
   @spec delete(String.t) :: tuple
   def delete(bucket) do
     GCloudStorage.Client.delete("/#{bucket}")
     |> extract_body
   end

   defp extract_body({:ok, %HTTPoison.Response{body: body, status_code: code}})
   when code in [200, 201, 204],
      do: {:ok, body}

   defp extract_body({_, %HTTPoison.Response{body: %{"error" => error}}}),
     do: {:error, convert_keys_to_atoms(error)}

   defp fill_buckets({:ok,  %{"items" => items}}),
     do: {:ok, Enum.map(items, &new_bucket/1)}

   defp fill_buckets({:ok, _}),
     do: {:ok, []}

   defp new_bucket(params) do
     %GCloudStorage.Bucket{}
     |> Map.merge convert_keys_to_atoms(params)
   end

   defp convert_keys_to_atoms(params) do
     for {key, val} <- params, into: %{}, do: {String.to_existing_atom(key), val}
   end
end
