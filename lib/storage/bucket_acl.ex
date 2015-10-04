defmodule GCloudStorage.BucketACL do
  defstruct [:kind, :id, :selfLink, :bucket, :entity, :role, :email, :entityId, :domain, :projectTeam, :etag]
end
