defmodule Redox.RequestTest do
  use ExUnit.Case
  alias Redox.Scheduling
  alias Redox.Patient
  alias Redox.Demographics
  alias Redox.Identifier

  describe "prepare_for_request/0" do
    test "returns a map" do
      query =
        Scheduling.New.put_meta(%Scheduling.New{
          patient: %Patient{
            identifiers: [%Identifier{id: "test", id_type: "test_type"}],
            demographics: %Demographics{}
          }
        })

      data = Redox.Request.new(query)

      IO.inspect(data: data)
    end
  end
end
