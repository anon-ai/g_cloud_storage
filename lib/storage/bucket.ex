defmodule GCloudStorage.Bucket do
  defstruct [
    :kind, :id, :self_link, :project_number, :name,
    :time_created, :updated, :metageneration, :owner,
    :location, :storage_class, :etag
  ]

  alias GCloudStorage.Client

  def list(project, opts) do
    GCloudStorage.Client
  end
end
