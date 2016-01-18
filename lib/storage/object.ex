defmodule GCloudStorage.Object do
  use Pipe

  @doc """
  Upload object
  """
  @spec upload(String.t, String.t, String.t, String.t) :: tuple
  def upload bucket, name, content, media_type do
    simple_upload bucket, name, content, media_type
  end

  @doc """
  Simple upload
  """
  @spec simple_upload(String.t, String.t, String.t, String.t) :: tuple
  def simple_upload bucket, name, content, media_type do
    headers = %{
      "Content-type" => media_type,
      "Content-length" => String.length(content)
    }

    GCloudStorage.Uploadclient.post("#{bucket}/o?uploadType=media&name=#{name}", content, headers)
    |> extract_body
  end

  defp extract_body({:ok, %HTTPoison.Response{body: body, status_code: code}})
  when code in [200, 201, 204],
    do: {:ok, body}

  defp extract_body({_, %HTTPoison.Response{body: %{"error" => error}}}),
    do: {:error, convert_keys_to_atoms(error)}

  defp convert_keys_to_atoms(params) do
    for {key, val} <- params, into: %{}, do: {String.to_existing_atom(key), val}
  end

end
