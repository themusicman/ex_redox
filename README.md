# Redox (pre-alpha)

Elixir package to interact with the Redox API

## Installation

Example

```elixir
alias Redox.Scheduling
alias Redox.Patient
alias Redox.Demographics
alias Redox.Identifier

%Scheduling.New{
  patient: %Patient{
    identifiers: [%Identifier{id: "123", id_type: "MR"}],
    demographics: %Demographics{}
  }
}
|> Scheduling.New.put_meta()
|> Redox.request()
```

## To get an access token

Configure ex_redox then call

```elixir

access_token = Redox.access_token()

```

## Configuration

See the Redox authentication documentation for the values below. The easiest way to get these values is to download the Postman environment file in the Redox administration UI.

```elixir
config :joken,
  ex_redox: [
    signer_alg: "RS384",
    jose_extra_headers: %{"kid" => "{kid}"},
    key_pem: System.get_env("REDOX_PEM")
  ]

config :ex_redox, :redox_client_id, "{client_id}"
```

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `ex_redox` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_redox, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/ex_redox>.
