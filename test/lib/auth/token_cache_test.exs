defmodule GCloudStorage.TokenCacheTest do
  use ExUnit.Case

  alias GCloudStorage.TokenCache
  alias GCloudStorage.TestConfig, as: Config

  setup_all do
   TokenCache.start_link
   :ets.new(Config.ets[:table], [:set, :public, :named_table, {:read_concurrency, true}])
    on_exit fn ->
      if (:ets.info(Config.ets[:table]) != :undefined) do
        :ets.delete_all_objects(Config.ets[:table])
      end
      :ok
    end
   :ok
  end


  test "it refresh  expired token" do
    secret = "secret"
    timeout = div(Config.token[:timeout], 2)
    token = TokenCache.access_token

    refute token  == secret
    :timer.sleep(timeout)

    assert token == TokenCache.access_token
    :timer.sleep(timeout)

    :ets.insert(Config.ets[:table], {Config.ets[:token_key], secret})
    assert TokenCache.access_token == secret
  end
end
