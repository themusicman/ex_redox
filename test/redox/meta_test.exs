defmodule Redox.MetaTest do
  use ExUnit.Case
  alias Redox.Media
  alias Redox.Meta

  describe "put/2" do
    test "puts meta into a type" do
      now = DateTime.utc_now() |> DateTime.to_iso8601()

      query = Meta.put(%Media.New{}, now: now)

      assert query.meta.data_model == "Media"
      assert query.meta.event_type == "New"
      assert query.meta.test == false
      assert query.meta.event_date_time == now
    end
  end
end
