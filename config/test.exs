use Mix.Config

config :g_cloud_storage,
  credentials:    "test/fixture/storage.json",
  private_key:    "test/fixture/storage.key.pem",
  # token_provider: GCloudStorage.DummyAccessToken,
  token_lifetime: 2
