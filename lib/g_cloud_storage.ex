defmodule GCloudStorage do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(GCloudStorage.TokenCache, [])
    ]

    opts = [strategy: :one_for_one, name: GCloudStorage.Supervisor]
   {:ok, pid} =  Supervisor.start_link(children, opts)
  end

end
