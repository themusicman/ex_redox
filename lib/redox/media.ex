defmodule Redox.Media do
  @moduledoc """
    Represents Redox Media data

    See [Redox API Docs](https://developer.redoxengine.com/data-models/Media.html)

  """

  alias Redox.Provider

  @typedoc """
  Availability

  Supported values for availability:
  Available
  Unavailable
  Obsolete
  Deleted
  Cancelled
  """
  @type availability :: binary()

  @typedoc """
  Redox Location
  """
  @type t :: %{
          file_type: binary(),
          file_name: binary(),
          file_contents: binary(),
          document_type: binary(),
          document_id: binary(),
          document_description: binary(),
          creation_date_time: binary(),
          service_date_time: binary(),
          direct_address_from: binary(),
          direct_address_to: binary(),
          provider: Provider.t(),
          authenticated: boolean(),
          authenticator: struct(),
          availability: availability(),
          notifications: [map()]
        }

  defstruct file_type: nil,
            file_name: nil,
            file_contents: nil,
            document_type: nil,
            document_id: nil,
            document_description: nil,
            creation_date_time: nil,
            service_date_time: nil,
            direct_address_from: nil,
            direct_address_to: nil,
            provider: nil,
            authenticated: nil,
            authenticator: nil,
            availability: nil,
            notifications: nil
end
