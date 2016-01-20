use Mix.Config

config :g_cloud_storage,
  token_lifetime: 2

config :exvcr, [
  vcr_cassette_library_dir: "test/fixture/vcr_cassettes",
  custom_cassette_library_dir: "test/fixture/custom_cassettes"
]
