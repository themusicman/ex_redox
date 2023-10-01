defmodule Redox.Provider.Query do
  defstruct meta: nil,
            provider: nil

  def put_meta(meta) do
    %{
      meta
      | data_model: "Provider",
        event_type: "ProviderQuery",
        event_date_time: DateTime.utc_now() |> DateTime.to_iso8601()
    }
  end
end
