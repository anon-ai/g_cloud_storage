defmodule GCloudStorage.BucketParams do
  defstruct [:name, :acl, :cors, :defaultObjectAcl, :lifecycle, :location, :logging, :storageClass, :versioning, :website]
end
