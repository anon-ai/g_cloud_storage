defmodule GCloudStorage.Bucket do
  # defstruct [
  #   :kind, :id, :selfLink, :projectNumber, :name,
  #   :time_created, :updated, :metageneration, :owner,
  #   :location, :storageClass, :etag
  # ]
  defstruct [:name, :acl, :cors, :defaultObjectAcl, :lifecycle, :location, :logging, :storageClass, :versioning, :website]

   alias GCloudStorage.Client

   @doc """
   Retrieve list of buckets for the given project
   """
   @spec list(String.t, map) :: list
   def list(project, opts \\ %{}) do
     params = Map.put_new opts, :project, project
     get_with_success("", params)
   end

   @doc """
   Insert new bucket
   """
   @spec insert(String.t, map) :: map
   def insert(project, params = %GCloudStorage.Bucket{}) do
     payload = Poison.encode!(params) 
     post_with_success("?project=#{project}", payload)
   end

   defp get_with_success(url, params) do
     {:ok, %HTTPoison.Response{body: body}} = GCloudStorage.Client.get(url, [], params: params)
     body
   end

   defp post_with_success(url, params) do
     {:ok, %HTTPoison.Response{body: body}} = GCloudStorage.Client.post(url, params, %{"Content-type" => "application/json"})
     body
   end
end
