defmodule AocDay2 do
  def run do
    retrieve_input
    |> sliding_chunk_by_3
    |> compute_sliding_sum
    |> determine_deltas({0, 0})
  end

  defp sliding_chunk_by_3(input) do
    Enum.chunk_every(input, 3, 1, :discard)
  end

  defp compute_sliding_sum(input) do
    input
    |> Enum.map(&Enum.sum/1)
  end

  defp determine_deltas([head | tail], {increases, decreases}) do
    deltas = cond do
      Enum.empty?(tail) ->
        {increases, decreases}
      head == List.first(tail) ->
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

  defp retrieve_input do
    File.read!("./input.txt")
    |> parse_input
  end

  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
  end
end
