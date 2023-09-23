defmodule Redox do
  @moduledoc """
  Documentation for `Redox`.
  """

  alias Redox.Request

  def request(query) do
    (Application.get_env(:ex_redox, :redox_url, "https://api.redoxengine.com/") <> "endpoint")
    |> Request.new()
    |> Request.put_data(query)
    |> Request.send()
  end

  def auth_token() do
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
