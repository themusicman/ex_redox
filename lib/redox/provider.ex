defmodule Redox.Provider do
  @moduledoc """
  Represents Redox Provider
  """
  alias Redox.Address
  alias Redox.Location
  alias Redox.PhoneNumber

  @typedoc """
  Redox Provider
  """
  @type t :: %{
          id: binary(),
          id_type: binary(),
          first_name: binary(),
          last_name: binary(),
          credentials: [binary()],
          address: Address.t(),
          email_addresses: [binary()],
          phone_number: PhoneNumber.t(),
          location: Location.t()
        }

  defstruct id: nil,
            id_type: nil,
            first_name: nil,
            last_name: nil,
            credentials: nil,
            address: nil,
            email_addresses: nil,
            phone_number: nil,
            location: nil
end
