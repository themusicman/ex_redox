defmodule Redox.PatientSearch.Query do
  defstruct meta: nil,
            patient: nil,
            appointment_info: nil,
            visit: nil

  def put_meta(meta) do
    %{
      meta
      | data_model: "PatientSearch",
        event_type: "Query",
        event_date_time: DateTime.utc_now() |> DateTime.to_iso8601()
    }
  end
end
