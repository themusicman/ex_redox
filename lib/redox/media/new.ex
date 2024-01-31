defmodule Redox.Media.New do
  @moduledoc """
    Represents the Media^New data model and event type

    A New message is used to add a new document to the patient's chart.

    See [Redox API Docs](https://developer.redoxengine.com/data-models/Media.html#New)
  """

  @typedoc """
  Redox Media New
  """
  @type t :: %{
          meta: Redox.Meta.t(),
          media: struct(),
          patient: struct(),
          visit: struct(),
          orders: [struct()]
        }

  defstruct meta: nil, media: nil, patient: nil, visit: nil, orders: nil

  defimpl Redox.Metable do
    def put(type, meta) do
      Map.put(type, :meta, %{meta | data_model: "Media", event_type: "New"})
    end
  end
end
