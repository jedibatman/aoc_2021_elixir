defmodule AocDay3 do
  def run do
    retrieve_input
  end

  defp retrieve_input do
    File.read!("./input.txt")
    |> parse_input
  end

  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
  end
end
