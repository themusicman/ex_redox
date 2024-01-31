defmodule Redox.Location do
  @moduledoc """
  Represents Redox Location
  """
  alias Redox.Identifier

  @typedoc """
  Redox Location
  """
  @type t :: %{
          type: binary(),
          facility: binary(),
          facility_identifiers: [Identifier.t()],
          department: binary(),
          department_identifier: [Identifier.t()],
          room: binary()
        }

  defstruct type: nil,
            facility: nil,
            facility_identifiers: nil,
            department: nil,
            department_identifier: nil,
            room: nil
end
