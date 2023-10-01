defimpl Redox.Request.Serializer, for: Redox.Provider.Query do
  use Redox.Request.Data

  def encode(query) do
    prepare(query)
  end

  def decode(query, json) do
    IO.inspect(json: json)

    Enum.map(get_in(json, ["Providers"]), fn provider ->
      %Redox.Provider{}
    end)
  end
end
