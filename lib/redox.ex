defmodule Redox do
  @moduledoc """
  Documentation for `Redox`.
  """

  alias Redox.Request

  @doc """
  Gets an access_token using the legacy authentication
  """
  def access_token(:legacy) do
    request =
      (Application.get_env(:ex_redox, :redox_url, "https://api.redoxengine.com/") <>
         "auth/authenticate")
      |> Request.new()

    request = %{
      request
      | data: %{
          "apiKey" => Application.get_env(:ex_redox, :redox_api_key),
          "secret" => Application.get_env(:ex_redox, :redox_secret)
        },
        auth: true,
        legacy: true
    }

    # TODO handle the refresh token
    %{"accessToken" => access_token} = Request.send(request)
    access_token
  end

  @doc """
  Gets an access_token using the new authentication
  """
  def access_token() do
    request =
      (Application.get_env(:ex_redox, :redox_url, "https://api.redoxengine.com/") <>
         "v2/auth/token")
      |> Request.new()

    request = %{
      request
      | data: %{
          "grant_type" => "client_credentials",
          "client_assertion_type" => "urn:ietf:params:oauth:client-assertion-type:jwt-bearer",
          "client_assertion" => Redox.Auth.Token.client_assertion()
        },
        auth: true
    }

    %{"access_token" => access_token} = Request.send(request)
    access_token
  end
end
