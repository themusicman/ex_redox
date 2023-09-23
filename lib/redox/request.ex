defmodule Redox.Request do
  alias __MODULE__

  defstruct url: "", data: nil

  def new(url) do
    %Request{url: url}
  end

  def put_data(request, query) do
    %{request | data: prepare(query)}
  end

  def send(%Request{url: _url, data: nil}) do
    raise "data can't be nil"
  end

  def send(%Request{url: url, data: data}) do
    # make better
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
