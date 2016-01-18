defmodule GCloudStorage.BucketTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney, options: [clear_mock: true]
  use ExUnit.Case

  alias GCloudStorage.Bucket

  setup_all do
    HTTPoison.start
    {:ok, project: "exs-sandbox", bucket: "exs-sandbox-test-bucket"}
  end

  test "list empty project", context do
    use_cassette "empty_project" do
      assert {:ok, []} = Bucket.list(context[:project])
    end
  end

  test "list project with single bucket", context do
    name = context[:name]
    use_cassette "project_with_single_bucket" do
      assert {:ok, [%GCloudStorage.Bucket{name: name}]} = Bucket.list(context[:project])
    end
    # assert {:error, %{code: _, errors: _, message: _}} = Bucket.insert(project, params)
    # assert {:ok, [%GCloudStorage.Bucket{name: name}]} = Bucket.list(project)
    # assert {:ok, nil} = Bucket.delete(name)
    # assert {:error, %{code: _, errors: _, message: _}} = Bucket.delete(name)
  end

  test "insert bucket into project", context do
    bucket = context[:bucket]
    params = %GCloudStorage.BucketParams{name: bucket}
    use_cassette "insert_first_bucket" do
      assert {:ok, %GCloudStorage.Bucket{name: bucket}} = Bucket.insert(context[:project], params)
    end
  end
  # test "predifined acl"
  # test "predifned defulat object acl"
end
