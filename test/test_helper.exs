defmodule GCloudStorage.TestConfig do
  def ets do
    %{
      table: :mocks,
      token_key: "token"
    }
  end

  def token do
    %{
      timeout: Application.get_env(:g_cloud_storage, :token_lifetime)  * 1000
    }
  end

  def storage do
    %{
      project: "exs-sandbox"
    }
  end
end


ExUnit.start()
