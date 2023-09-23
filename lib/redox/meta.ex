defmodule Redox.Meta do
  defstruct data_model: "",
            event_type: "",
            event_date_time: "",
            test: false,
            source: nil,
            destinations: [],
            logs: [],
            facility_code: ""
end
