defmodule Redox.PatientSearch.Query do
  @moduledoc """
  Represents a Redox PatientSearch Query data model

  See [Redox API Docs](https://developer.redoxengine.com/data-models/PatientSearch.html#Query)
  """

  alias Redox.Patient

  @typedoc """
  Redox PatientSearch Query
  """
  @type t :: %{
          meta: Redox.Meta.t(),
          patient: Patient.t()
        }

  defstruct meta: nil,
            patient: nil

  defimpl Redox.Metable do
    def put(type, meta) do
      Map.put(type, :meta, %{meta | data_model: "PatientSearch", event_type: "Query"})
    end
  end
end
