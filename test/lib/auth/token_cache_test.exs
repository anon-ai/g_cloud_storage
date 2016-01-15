defmodule GCloudStorage.TokenCacheTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  use ExUnit.Case

  alias GCloudStorage.TokenCache
  alias GCloudStorage.TestConfig, as: Config

  setup_all do
    TokenCache.start_link
    HTTPoison.start
    :ok
  end


  test "it refresh  expired token" do
    use_cassette "fetch_token" do
      secret = "secret"
      timeout = div(Config.token[:timeout], 2)
      token = TokenCache.access_token
    end
    # refute token  == secret
    # :timer.sleep(timeout)

    # assert token == TokenCache.access_token
    # :timer.sleep(timeout)

    # :ets.insert(Config.ets[:table], {Config.ets[:token_key], secret})
    # assert TokenCache.access_token == secret
  end
end
