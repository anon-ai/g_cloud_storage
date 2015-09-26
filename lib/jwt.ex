defmodule GCloudStorage.JWT do
  alias GCloudStorage.ApiCredentials, as: Credentials

  @refresh_url "https://www.googleapis.com/oauth2/v3/token"
  @permissions "https://www.googleapis.com/auth/devstorage.full_control"
  @header       ~s({"alg":"RS256","typ":"JWT"})

  def compose do
    JsonWebToken.sign(claim_set, jwt_ex_options)
  end

  defp jwt_ex_options do
    %{alg: "RS256", key: private_key}
  end

  defp private_key do
    path = Credentials.private_key_path
    dir  = Path.dirname(path)
    key  = Path.basename(path)
    JsonWebToken.Algorithm.RsaUtil.private_key(dir, key)
  end

  defp claim_set do
    %{
      iss:   Credentials.client_email,
      scope: @permissions,
      aud:   @refresh_url,
      iat:   seconds_since_epoch,
      exp:   one_hour_from_now
    }
  end

  defp seconds_since_epoch do
    {mega_secs, secs, _} = :os.timestamp
    (mega_secs * 1000000) + secs
  end

  defp one_hour_from_now, do:
    seconds_since_epoch + 3600
end
