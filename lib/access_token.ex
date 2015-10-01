defmodule GCloudStorage.AccessToken do
  @type t :: %GCloudStorage.AccessToken{token: String.t, expires_in: integer}
  defstruct token: "", expires_in: 0

  alias GCloudStorage.Settings, as: Settings

  @refresh_url "https://www.googleapis.com/oauth2/v3/token"
  @permissions "https://www.googleapis.com/auth/devstorage.full_control"
  @header       ~s({"alg":"RS256","typ":"JWT"})
  @access_token_exchange_url "https://www.googleapis.com/oauth2/v3/token"

  def refresh do
    form_data = [
        grant_type: "urn:ietf:params:oauth:grant-type:jwt-bearer",
        assertion: jwt
    ]

    {:ok, %HTTPoison.Response{body: body, status_code: 200}} = HTTPoison.post(
      "https://www.googleapis.com/oauth2/v3/token",
      {:form, form_data}
    )
    token = Poison.decode!(body)
    %GCloudStorage.AccessToken{token: token["access_token"], expires_in: token["expires_in"]}
  end

  # JWT generation

  defp jwt do
    claim_set |>
      JsonWebToken.sign(%{alg: "RS256", key: private_key})
  end

  defp private_key do
    path = Credentials.private_key_path
    dir  = Path.dirname(path)
    key  = Path.basename(path)
    JsonWebToken.Algorithm.RsaUtil.private_key(dir, key)
  end

  defp claim_set do
    %{
      iss:   Settings.client_email,
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
