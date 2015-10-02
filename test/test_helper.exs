defmodule GCloudStorage.TestConfig do
  def ets do
    %{
      table: :mocks,
      token_key: "token"
    }
  end

  def token do
    %{
      timeout: 1000
    }
  end
end


ExUnit.start()
