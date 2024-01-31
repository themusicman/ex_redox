defmodule Redox.Diagnosis do
  @moduledoc """
  Represents Redox Diagnosis
  """

  @typedoc """
  Redox Diagnosis
  """
  @type t :: %{
          code: binary(),
          codeset: binary(),
          name: binary(),
          type: binary(),
          document_date_time: binary()
        }

  defstruct code: nil, codeset: nil, name: nil, type: nil, document_date_time: nil
end
