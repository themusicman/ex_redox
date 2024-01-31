defmodule Redox.Identifier do
  @moduledoc """
  Represents Redox Identifier
  """

  @typedoc """
  Redox Identifier
  """
  @type t :: %{
          id: binary(),
          id_type: binary()
        }

  defstruct id: nil, id_type: nil
end
