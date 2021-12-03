defmodule AocDay1 do
  def run do
    retrieve_input()
    |> determine_deltas({0, 0})
  end

  defp retrieve_input do
    File.read!("./input.txt")
    |> parse_input
  end

  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  defp determine_deltas([head | tail], {increases, decreases}) do
    deltas = cond do
      Enum.empty?(tail) ->
        {increases, decreases}
      head > List.first(tail) ->
        {increases, decreases + 1}
      head < List.first(tail) ->
        {increases + 1, decreases}
    end

    determine_deltas(tail, deltas)
  end

  defp determine_deltas([], {increases, decreases}) do
    { increases, decreases }
  end
end
