defmodule GCloudStorage.BucketTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias GCloudStorage.Bucket

  setup_all do
    HTTPoison.start
    {:ok, project: "exs-sandbox", bucket: "exs-sandbox-test-bucket"}
  end

  test "list empty project", context do
     use_cassette "empty_project" do
      GCloudStorage.AccessToken.refresh
      assert {:ok, []} = Bucket.list(context[:project])
     end
  end

  test "list project with single bucket", context do
    name = context[:name]
    use_cassette "project_with_single_bucket" do
      GCloudStorage.AccessToken.refresh
      assert {:ok, [%GCloudStorage.Bucket{name: name}]} = Bucket.list(context[:project])
    end
  end

  test "successfull bucket creation", context do
    bucket = context[:bucket]
    params = %GCloudStorage.BucketParams{name: bucket}
    use_cassette "successfull_bucket_creation" do
      GCloudStorage.AccessToken.refresh
      assert {:ok, %GCloudStorage.Bucket{name: bucket}} = Bucket.insert(context[:project], params)
    end
  end

  test "failed bucket creation", context do
      bucket = context[:bucket]
      params = %GCloudStorage.BucketParams{name: bucket}
      use_cassette "duplicated_bucket_insertion" do
        GCloudStorage.AccessToken.refresh
        assert {:error, %{code: _, errors: _, message: _}} = Bucket.insert(context[:project], params)
      end
  end

  test "successfull bucket deletion", context do
    use_cassette "successfull_bucket_deletion" do
      GCloudStorage.AccessToken.refresh
      assert {:ok, nil} = Bucket.delete(context[:bucket])
    end
  end

  test "failed bucket deletion", context do
    use_cassette "failed_bucket_deletion" do
      GCloudStorage.AccessToken.refresh
      assert {:error, %{code: _, errors: _, message: _}} = Bucket.delete(context[:bucket])
    end
  end

  # test "predifined acl"
  # test "predifned defulat object acl"
end
