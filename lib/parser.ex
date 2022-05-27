defmodule GenReport.Parser do
  def parse_file(filename) do
    filename
    |> File.stream!()
    |> Enum.reduce(
      %{},
      fn line, report ->
        [name, hours, day, month, year] = parse_line(line)
        Map.put(report, name, report[name] + hours)
      end
    )
  end

  defp parse_line(line) do
    [hd | tail] =
      String.trim(line)
      |> String.split(",")

    [hd | Enum.map(tail, &String.to_integer/1)]
  end
end
