defmodule GCloudStorage.Token.JWTest do
  use ExUnit.Case

  test "it compose JWT token" do
    token =
      GCloudStorage.JWT.compose
      |> String.split(".")
    assert length(token) == 3
  end
end
