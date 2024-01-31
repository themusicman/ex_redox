defmodule Redox.Visit do
  @moduledoc """
  Represents a Redox Visit
  """
  defstruct visit_number: nil,
            account_number: nil,
            visit_date_time: nil,
            patient_class: nil,
            status: nil,
            duration: nil,
            reason: nil,
            type: nil,
            instructions: nil,
            attending_provider: nil,
            consulting_provider: nil,
            referring_provider: nil,
            visit_provider: nil,
            location: nil,
            diagnoses: nil,
            equipment: nil
end
