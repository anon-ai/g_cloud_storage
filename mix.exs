defmodule GCloudStorage.Mixfile do
  use Mix.Project

  def project do
    [app: :g_cloud_storage,
     version: "0.0.1",
     elixir: "~> 1.0",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:logger, :httpoison]]
  end

  defp deps do
    [
      {:poison,         "~> 1.5"},
      {:httpoison,      "~> 0.7.2"},
      {:json_web_token, github: "lessless/json_web_token_ex"}
    ]
  end
end
