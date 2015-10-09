defmodule GCloudStorage.BucketTest do
  use ExUnit.Case

  alias GCloudStorage.TestConfig, as: Config
  alias GCloudStorage.Bucket

  test "simple CRUD for buckets in the project" do
    project = Config.storage[:project]
    name = "#{project}-test-bucket"
    params = %GCloudStorage.BucketParams{name: name}

    assert {:ok, []} = Bucket.list(project)
    assert {:ok, %GCloudStorage.Bucket{name: name}} = Bucket.insert(project, params)
    assert {:error, %{code: _, errors: _, message: _}} = Bucket.insert(project, params)
    assert {:ok, [%GCloudStorage.Bucket{name: name}]} = Bucket.list(project)
    assert {:ok, nil} = Bucket.delete(name)
    assert {:error, %{code: _, errors: _, message: _}} = Bucket.delete(name)
  end

  # test "predifined acl"
  # test "predifned defulat object acl"
end
