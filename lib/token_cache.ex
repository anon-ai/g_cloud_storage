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
    token = token_provider.refresh
    retrieved = :os.timestamp
    {:reply, token.token, {token, retrieved}}
  end

  def token_provider do
    Application.get_env(:g_cloud_storage, :token_provider)
  end
end
