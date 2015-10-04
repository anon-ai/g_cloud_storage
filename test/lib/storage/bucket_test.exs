defmodule GCloudStorage.BucketTest do
  use ExUnit.Case

  alias GCloudStorage.TestConfig, as: Config
  alias GCloudStorage.Bucket

  test "retrives buckets in the project" do
    buckets = Bucket.list(Config.storage[:project])
    assert length(buckets[:items]) == 2
    assert %GCloudStorage.Bucket{} = List.first(buckets[:items])
  end
end
