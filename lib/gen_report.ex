defmodule GenReport do
  def build(filename) do
    filename
    |> File.stream!()
    |> Enum.reduce(
      report_acc(),
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

  def report_acc, do: Enum.into(1..10, %{}, &{Integer.to_string(&1), 0})
end
