defmodule GCloudStorage.Token.JWT.ComposerTest do
  use ExUnit.Case

  test "it compose JWT token" do
    token =
      GCloudStorage.Token.JWT.Composer.compose
      |> String.split(".")
    assert length(token) == 3
  end
end
