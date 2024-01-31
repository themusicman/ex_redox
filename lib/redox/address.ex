defmodule Redox.Address do
  @moduledoc """
  Represents Redox Address
  """

  @typedoc """
  Redox Address
  """
  @type t :: %{
          street_address: binary(),
          city: binary(),
          state: binary(),
          zip: binary(),
          county: binary(),
          country: binary()
        }

  defstruct street_address: nil, city: nil, state: nil, zip: nil, county: nil, country: nil
end
