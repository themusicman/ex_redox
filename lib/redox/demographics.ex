defmodule Redox.Demographics do
  @moduledoc """
    Represents Redox Demographics
  """
  alias Redox.Address
  alias Redox.PhoneNumber

  @typedoc """
  Redox Demographics
  """
  @type t :: %{
          first_name: binary(),
          middle_name: binary(),
          last_name: binary(),
          dob: binary(),
          phone_number: PhoneNumber.t(),
          email_address: [],
          address: Address.t()
        }

  defstruct first_name: nil,
            middle_name: nil,
            last_name: nil,
            dob: nil,
            phone_number: nil,
            email_addresses: nil,
            address: nil
end
