defmodule GCloudStorage.TokenCache do
  use GenServer

  #Client API
  def start_link do
    GenServer.start_link(__MODULE__, {%GCloudStorage.AccessToken{}, {}}, name: __MODULE__)
  end

  def access_token do
    GenServer.call(__MODULE__, :access_token)
  end

  # Server API
  def handle_call(:access_token, _from, {%GCloudStorage.AccessToken{token: ""}, _}) do
    refresh()
  end

  def handle_call(:access_token, _from, {access_token = %GCloudStorage.AccessToken{}, retrived}) do
    if (token_expired(retrived, access_token.expires_in)) do
      refresh()
    else
      {:reply, access_token.token, {access_token, retrived}}
    end
  end

  defp refresh do
    token = token_provider().refresh
    retrieved = :os.timestamp
    {:reply, token.token, {token, retrieved}}
  end

  defp token_expired(retrived, expires_in) do
    now = :os.timestamp
    :timer.now_diff(now, retrived) >= (expires_in * 1000000)
  end

  defp token_provider do
    Application.get_env(:g_cloud_storage, :token_provider)
  end
end
