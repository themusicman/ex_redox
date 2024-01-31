defmodule Redox.Media.NewTest do
  use ExUnit.Case
  alias Redox.Media.New

  describe "new" do
    test "adds meta to query" do
      now = DateTime.utc_now() |> DateTime.to_iso8601()

      query =
        New.new(now: now)

      assert query.meta.data_model == "Media"
      assert query.meta.event_type == "New"
      assert query.meta.test == false
      assert query.meta.event_date_time == now
    end
  end
end
