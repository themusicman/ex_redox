defmodule Redox do
  @moduledoc """
  Documentation for `Redox`.
  """

  alias Redox.Request

  def request(query) do
    Application.get_env(:ex_redox, :redox_url, nil)
    |> Request.new()
    |> Request.put_data(query)
    |> Request.send()
  end
end
