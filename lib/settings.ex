defmodule GCloudStorage.Settings do
  def client_email,     do: read_config()["client_email"]
  def private_key_path, do: Application.get_env(:g_cloud_storage, :private_key)

  defp read_config do
    {:ok, json} = File.read Application.get_env(:g_cloud_storage, :credentials)
    Poison.decode! json
  end
end
