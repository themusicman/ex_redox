defprotocol Redox.Metable do
  alias Redox.Meta
  @spec put(term(), Meta.t()) :: term()
  def put(t, meta)
end
