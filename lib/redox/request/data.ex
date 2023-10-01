defmodule Redox.Request.Data do
  defmacro __using__(_opts) do
    quote do
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
  end
end
