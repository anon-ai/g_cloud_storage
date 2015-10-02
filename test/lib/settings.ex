defmodule GCloudStorage.SettingsTest do
  use ExUnit.Case

  alias GCloudStorage.Settings

  test "it returns client email" do
    assert Regex.match?(~r/.*@developer.gserviceaccount.com$/, Settings.client_email)
  end

  test "it points to valid rsa key" do
    assert Regex.match?(~r/.*storage.key.pem$/, Settings.private_key_path)
  end

  test "it returns token expiration time" do
    assert Integer.parse(Settings.token_expiration)
  end
end
