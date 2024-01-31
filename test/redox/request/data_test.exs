defmodule Redox.Request.DataTest do
  use ExUnit.Case
  alias Redox.Request.Data
  alias Redox.Identifier
  alias Redox.Demographics
  alias Redox.Patient
  alias Redox.Scheduling
  alias Redox.Meta

  describe "to_redox/1" do
    test "returns a map" do
      now = DateTime.utc_now() |> DateTime.to_iso8601()

      query =
        %Scheduling.New{
          patient: %Patient{
            indentifiers: [%Identifier{id: "test", id_type: "test_type"}],
            demographics: %Demographics{}
          }
        }
        |> Meta.put(now: now)

      data = Data.to_redox(query)

      assert %{
               "Meta" => %{
                 "DataModel" => "Scheduling",
                 "EventDateTime" => now,
                 "EventType" => "New",
                 "Test" => false
               },
               "Patient" => %{
                 "Demographics" => %{},
                 "Indentifiers" => [%{"ID" => "test", "IDType" => "test_type"}]
               }
             } == data
    end

    test "converts items in a list" do
    end

    test "does nothing to a non-struct/list/map value" do
    end
  end

  describe "to_redox_key/1" do
    test "camelizes the atom key and converts to string" do
    end

    test "converts :id to ID" do
    end

    test "converts :id_type to IDType" do
    end
  end
end
