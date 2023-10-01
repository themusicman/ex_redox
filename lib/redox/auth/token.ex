defmodule Redox.Auth.Token do
  use Joken.Config

  def token_config do
    client_id = Application.get_env(:ex_redox, :redox_client_id)

    default_claims(iss: client_id, aud: "https://api.redoxengine.com/v2/auth/token")
    |> add_claim("sub", fn -> client_id end, &(&1 == client_id))
  end

  def client_assertion() do
    {:ok, token, _claims} = generate_and_sign(%{}, :ex_redox)
    token
  end
end
