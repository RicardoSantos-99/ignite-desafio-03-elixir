defmodule GenReport.Parser do
  def parse_file(filename) do
    filename
    |> File.stream!()
    |> Enum.map(&parse_line/1)
  end

  defp parse_line(line) do
    [hd | tail] =
      String.trim(line)
      |> String.split(",")

    [hd | Enum.map(tail, &String.to_integer/1)]
  end
end
