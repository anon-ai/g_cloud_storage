defmodule GCloudStorage.DummyAccessToken do
  @table :mocks
  @key   "token"

  @doc """
  Lookups token from the ets table :mocks.
  If table doesn't exist or value isn't non-empty string, then it's generated
 """
  def refresh do
    token =
      :ets.info(@table)
      |> fetch_or_generate
    %GCloudStorage.AccessToken{token: token, expires_in: expiration_time}
  end

  defp fetch_or_generate(:undefined), do: generate

  defp fetch_or_generate(_) do
    case :ets.lookup(@table, @key) do
      [{@key, token}] -> token
      []    -> generate
    end
  end

  defp generate do
    :crypto.strong_rand_bytes(16)
    |> :base64.encode_to_string
    |> to_string
  end

  defp expiration_time do
    Application.get_env(:g_cloud_storage, :token_lifetime)
  end
end
