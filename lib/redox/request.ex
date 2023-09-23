defmodule Redox.Request do
  alias __MODULE__

  defstruct url: "", data: nil, auth: false

  def new(url) do
    %Request{url: url}
  end

  def put_data(request, query) do
    %{request | data: prepare(query)}
  end

  def put_api_key(_request, nil, _secret), do: raise("api_key must be configured")
  def put_api_key(_request, _api_key, nil), do: raise("secret must be configured")
  def put_api_key(_request, nil, nil), do: raise("api_key and secret must be configured")

  def put_api_key(request, api_key, secret) do
    %{request | data: %{"apiKey" => api_key, "secret" => secret}}
  end

  def send(%Request{url: _url, data: nil}) do
    raise "data can't be nil"
  end

  def send(%Request{url: url, data: data, auth: false}) do
    # Todo make better ex. handle auth token expired more gracefully 
    case HTTPoison.post(url, Jason.encode!(data), [{"Content-Type", "application/json"}]) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        IO.puts(body)

      {:ok, %HTTPoison.Response{status_code: 201, body: body}} ->
        IO.puts(body)

      {:ok, %HTTPoison.Response{status_code: 400, body: body}} ->
        IO.puts(body)

      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect(reason)
    end
  end

  def send(%Request{url: url, data: data, auth: true}) do
    # make better
    body = URI.encode_query(data)

    case HTTPoison.post(url, body, %{"Content-Type" => "application/x-www-form-urlencoded"}) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        Jason.decode!(body)

      {:ok, %HTTPoison.Response{status_code: 400, body: body}} ->
        IO.inspect(body)

      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect(reason)
    end
  end

  @doc """
  Turn structs into a map
  """
  def prepare(nil), do: nil

  def prepare(value) when is_struct(value) do
    prepare(Map.from_struct(value))
  end

  def prepare(value) when is_map(value) do
    value
    |> Enum.reduce([], fn {key, value}, acc ->
      if is_nil(value) do
        acc
      else
        [{prepare_key(key), prepare(value)} | acc]
      end
    end)
    |> Enum.into(%{})
  end

  def prepare([head | tail]) do
    [prepare(head) | prepare(tail)]
  end

  def prepare(value) do
    value
  end

  def prepare_key(:id), do: "ID"
  def prepare_key(:id_type), do: "IDType"

  def prepare_key(key) do
    key |> Atom.to_string() |> Macro.camelize()
  end
end
