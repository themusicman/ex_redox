# Redox (pre-alpha)

Elixir package to interact with the Redox API

## Installation

Example

```elixir
alias Redox.Scheduling
alias Redox.Patient
alias Redox.Patient.Demographics
alias Redox.Identifier

%Scheduling.New{
  patient: %Patient{
    indentifiers: [%Identifier{id: "123", id_type: "MR"}],
    demographics: %Demographics{}
  }
}
|> Scheduling.New.put_meta()
|> Redox.request()
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

