defmodule GCloudStorage.AccessTokenTest do
  use ExUnit.Case

  test "it refresh access token" do
    %GCloudStorage.AccessToken{token: token, expires_in: expires_in}  = GCloudStorage.AccessToken.refresh
    assert token
    assert expires_in
  end

  # test "it compose JWT token" do
  #   token =
  #     GCloudStorage.JWT.compose
  #   |> String.split(".")
  #   assert length(token) == 3
  # end
end
