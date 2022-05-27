defmodule GenReport.Parser do
  def parse_file(filename) do
    filename
    |> File.stream!()
    |> Stream.map(&parse_line/1)
  end

  defp parse_line(line) do
    line
    |> String.trim()
    |> String.split(",")
    |> convert_list()
  end

  defp convert_list([hd | tail]) do
    [hd | Enum.map(tail, &String.to_integer/1)]
  end
end
