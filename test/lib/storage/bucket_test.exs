defmodule GCloudStorage.BucketTest do
  use ExUnit.Case

  alias GCloudStorage.TestConfig, as: Config
  alias GCloudStorage.Bucket

  test "simple CRUD for buckets in the project" do
    project = Config.storage[:project]

    # read
    buckets = Bucket.list(project)
    assert length(buckets) == 0

    # insert
    params = %GCloudStorage.Bucket{name: "test_bucket"}
    bucket = Bucket.insert(project, bucket)
    assert %GCloudStorage.Bucket{} = List.first(buckets[:items])
  end

  # test "predifined acl"
  # test "predifned defulat object acl"
end
