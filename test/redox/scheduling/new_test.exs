defmodule Redox.Scheduling.NewTest do
  use ExUnit.Case
  alias Redox.Scheduling.New
  alias Redox.Patient
  alias Redox.Patient.Demographics
  alias Redox.Identifier

  describe "put_meta/2" do
    test "adds meta to query" do
      query =
        New.put_meta(%New{
          patient: %Patient{
            identifiers: [%Identifier{id: "123", id_type: "MR"}],
            demographics: %Demographics{}
          }
        })

      IO.inspect(query: query)
      assert query.meta.data_model == "Scheduling"
      assert query.meta.event_type == "New"
      assert query.meta.test == false
    end
  end
end
