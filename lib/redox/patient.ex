defmodule Redox.Patient do
  @moduledoc """
    Represents Redox Patient
  """

  alias Redox.Identifier

  @typedoc """
  Redox Patient
  """
  @type t :: %{
          identifiers: [Identifier.t()],
          demographics: struct(),
          notes: []
        }

  defstruct identifiers: [], demographics: nil, notes: nil
end
