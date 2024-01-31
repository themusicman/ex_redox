defmodule Redox.Meta do
  @moduledoc """
    Represents Redox Meta

    See [Redox API Docs](https://developer.redoxengine.com/data-models/)
  """

  alias __MODULE__

  @typedoc """
    Meta 
  """
  @type t :: %{
          data_model: binary(),
          event_type: binary(),
          event_date_time: binary(),
          test: boolean(),
          source: struct(),
          destinations: [struct()],
          logs: [struct()],
          facility_code: binary()
        }

  defstruct data_model: "",
            event_type: "",
            event_date_time: "",
            test: false,
            source: nil,
            destinations: nil,
            logs: nil,
            facility_code: ""

  @spec put(struct(), keyword()) :: struct()
  def put(type, opts \\ []) do
    test = Keyword.get(opts, :test, false)
    destinations = Keyword.get(opts, :destinations, [])
    source = Keyword.get(opts, :source, nil)
    facility_code = Keyword.get(opts, :facility_code, nil)
    now = Keyword.get_lazy(opts, :now, fn -> DateTime.utc_now() |> DateTime.to_iso8601() end)

    Redox.Metable.put(
      type,
      %Meta{
        event_date_time: now,
        source: source,
        destinations: destinations,
        facility_code: facility_code,
        test: test
      }
    )
  end
end
