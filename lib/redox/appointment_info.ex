defmodule Redox.AppointmentInfo do
  @moduledoc """
  Represents Redox AppointmentInfo
  """

  @typedoc """
  Redox AppointmentInfo
  """
  @type t :: %{
          code: binary(),
          codeset: binary(),
          description: binary(),
          value: binary()
        }
  defstruct code: nil, codeset: nil, description: nil, value: nil
end
