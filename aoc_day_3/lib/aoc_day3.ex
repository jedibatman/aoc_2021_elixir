defmodule AocDay3 do
  def run do
    retrieve_input()
    |> expand_report_entries
    |> zip_on_columns
    |> Enum.map(&calculate_energy_bits/1)
    |> calculate_energy_rate
  end

  defp calculate_energy_rate(input) do
    input
    |> Enum.reduce(%{gamma_rate: "", epsilon_rate: ""}, fn bit_entry, acc ->
        %{ acc | gamma_rate: acc[:gamma_rate] <> bit_entry[:gamma_bit], epsilon_rate: acc[:epsilon_rate] <> bit_entry[:epsilon_bit]}
      end)
    |> Enum.map(fn {_, v} -> Integer.parse(v, 2) end)
    |> Enum.flat_map(&Tuple.to_list/1)
    |> Enum.filter(fn x -> is_integer(x) end)
    |> Enum.product
  end

  defp calculate_energy_bits(report_entry) do
    %{ "0" => zero_occurrences, "1" => one_occurrences } = Enum.frequencies(report_entry)

    cond do
      zero_occurrences > one_occurrences ->
        %{gamma_bit: "0", epsilon_bit: "1"}
      zero_occurrences < one_occurrences ->
        %{gamma_bit: "1", epsilon_bit: "0"}
    end
  end

  defp expand_report_entries(input), do: Enum.map(input, &String.codepoints/1)

  defp zip_on_columns(input), do: Enum.zip(input) |> Enum.map(&Tuple.to_list/1)

  defp retrieve_input do
    File.read!("./input.txt")
    |> parse_input
  end

  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
  end
end
