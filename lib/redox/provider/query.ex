defmodule Redox.Provider.Query do
  @moduledoc """
  Represents a Redox Provider Query data model
  """

  @typedoc """
  Redox Provider Query
  """
  @type t :: %{
          meta: Redox.Meta.t(),
          provider: struct()
        }

  defstruct meta: nil,
            provider: nil

  defimpl Redox.Metable do
    def put(type, meta) do
      Map.put(type, :meta, %{meta | data_model: "Provider", event_type: "ProviderQuery"})
    end
  end
end
