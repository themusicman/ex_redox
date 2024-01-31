defmodule Redox.Scheduling.New do
  @moduledoc """
  Represents a Redox Scheduling New data model
  """

  @typedoc """
  Redox Scheduling New
  """
  @type t :: %{
          meta: Redox.Meta.t(),
          patient: struct(),
          appointment_info: struct(),
          visit: struct()
        }
  defstruct meta: nil, patient: nil, appointment_info: nil, visit: nil

  defimpl Redox.Metable do
    def put(type, meta) do
      Map.put(type, :meta, %{meta | data_model: "Scheduling", event_type: "New"})
    end
  end
end
