defmodule Redox.Meta do
  alias __MODULE__

  defstruct data_model: "",
            event_type: "",
            event_date_time: "",
            test: false,
            source: nil,
            destinations: nil,
            logs: nil,
            facility_code: ""

  def new(attrs \\ []) do
    test = Keyword.get(attrs, :test, false)
    destinations = Keyword.get(attrs, :destinations, [])
    source = Keyword.get(attrs, :source, nil)
    facility_code = Keyword.get(attrs, :facility_code, nil)

    %Meta{
      source: source,
      destinations: destinations,
      facility_code: facility_code,
      test: test
    }
  end
end
