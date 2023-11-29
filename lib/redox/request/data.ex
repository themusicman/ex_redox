defmodule Redox.Request.Data do
  @doc """
  Turn structs into a map
  """
  def to_redox(nil), do: nil

  def to_redox(value) when is_struct(value) do
    to_redox(Map.from_struct(value))
  end

  def to_redox(value) when is_map(value) do
    value
    |> Enum.reduce([], fn {key, value}, acc ->
      if is_nil(value) do
        acc
      else
        [{to_redox_key(key), to_redox(value)} | acc]
      end
    end)
    |> Enum.into(%{})
  end

  def to_redox([head | tail]) do
    [to_redox(head) | to_redox(tail)]
  end

  def to_redox(value) do
    value
  end

  def to_redox_key(:dob), do: "DOB"
  def to_redox_key(:id), do: "ID"
  def to_redox_key(:id_type), do: "IDType"

  def to_redox_key(key) do
    key |> Atom.to_string() |> Macro.camelize()
  end

  @doc """
  Converts a json response from Redox
  """
  def from_redox(value) when is_map(value) do
    value =
      value
      |> Enum.reduce([], fn {key, value}, acc ->
        if is_nil(value) do
          acc
        else
          [{from_redox_key(key), from_redox(value)} | acc]
        end
      end)
      |> Enum.into(%{})
  end

  def from_redox([head | tail]) do
    [from_redox(head) | from_redox(tail)]
  end

  def from_redox(value) do
    value
  end

  def from_redox_key("DOB"), do: :dob
  def from_redox_key("ID"), do: :id
  def from_redox_key("IDType"), do: :id_type

  def from_redox_key(key) do
    key |> Macro.underscore() |> String.to_atom()
  end
end
