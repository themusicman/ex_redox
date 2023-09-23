defmodule Redox.Scheduling.New do
  alias Redox.Meta

  defstruct meta: nil, patient: nil, appointment_info: nil, visit: nil

  def put_meta(query, attrs \\ []) do
    test = Keyword.get(attrs, :test, false)

    %{
      query
      | meta: %Meta{
          data_model: "Scheduling",
          event_type: "New",
          event_date_time: DateTime.utc_now() |> DateTime.to_iso8601(),
          test: test
        }
    }
  end
end
