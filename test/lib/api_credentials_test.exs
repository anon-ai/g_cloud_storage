defmodule GCloudStorage.ApiCredentialsTest do
  use ExUnit.Case

  alias GCloudStorage.ApiCredentials

  test "it returns client email" do
    assert Regex.match?(~r/.*@developer.gserviceaccount.com$/, ApiCredentials.client_email)
  end

  test "it points to valid rsa key" do
    assert Regex.match?(~r/.*storage.key.pem$/, ApiCredentials.private_key_path)
  end
end
