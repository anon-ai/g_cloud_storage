use Mix.Config

config :g_cloud_storage,
  credentials: "priv/google/storage.json",
  private_key: "priv/google/storage.key.pem",
  token_lifetime: 3600,
  token_provider: GCloudStorage.AccessToken

  import_config "#{Mix.env}.exs"
