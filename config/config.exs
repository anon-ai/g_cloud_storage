use Mix.Config

config :g_cloud_storage,
  credentials: "priv/google/storage.json",
  private_key: "priv/google/storage.key.pem"

  import_config "#{Mix.env}.exs"
