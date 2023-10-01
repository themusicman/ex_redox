defmodule Redox.Data do
  alias Redox.Request

  @doc """
  Make a request to the Data Module API
  """
  def request(query, access_token) do
    (Application.get_env(:ex_redox, :redox_url, "https://api.redoxengine.com/") <> "endpoint")
    |> Request.new(query, access_token)
    |> Request.put_data()
    |> Request.send()
  end
end
