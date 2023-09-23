defmodule Redox do
  @moduledoc """
  Documentation for `Redox`.
  """

  alias Redox.Request

  def request(url, query) do
    url
    |> Request.new()
    |> Request.put_data(query)
    |> Request.send()
  end
end
