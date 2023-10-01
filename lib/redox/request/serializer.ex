defprotocol Redox.Request.Serializer do
  @spec encode(any()) :: any()
  def encode(query)

  @spec decode(any(), map()) :: any()
  def decode(query, json)
end
