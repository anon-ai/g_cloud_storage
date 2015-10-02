defmodule GCloudStorage.TokenCacheTest do
  use ExUnit.Case

  alias GCloudStorage.TokenCache
  alias GCloudStorage.AccessToken
  alias GCloudStorage.TestConfig, as: Config

  setup do
   {:ok, _pid} = TokenCache.start_link
   :ets.new(Config.ets[:table], [:set, :public, :named_table, {:read_concurrency, true}])
   :ok
  end


  test "it refresh  expired token" do
    secret = "secret"

    assert TokenCache.access_token != secret
    :timer.sleep(Config.token[:timeout])
    :ets.insert(Config.ets[:table], {Config.ets[:token_key], secret})
    assert TokenCache.access_token == secret
    :ets.delete_all_objects(Config.ets[:table])
  end
end
