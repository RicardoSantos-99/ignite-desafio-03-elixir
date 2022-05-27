defmodule GenReport do
  alias GenReport.Parser

  @available_names [
    "Cleiton",
    "Daniele",
    "Danilo",
    "Diego",
    "Giuliano",
    "Jakeliny",
    "Joseph",
    "Mayk",
    "Rafael",
    "Vinicius"
  ]

  def build(filename) do
    filename
    |> Parser.parse_file()
    |> Enum.reduce(
      report_acc(),
      fn line, report -> sum_values(line, report) end
    )
  end

  defp sum_values(
         [name, hours, _day, _month, _year],
         %{
           "all_hours" => names
         } = _report
       ) do
    all_hours = Map.put(names, name, names[name] + hours)

    %{
      "all_hours" => all_hours
    }
  end

  defp report_acc do
    %{
      "all_hours" => Enum.into(@available_names, %{}, &{&1, 0})
    }
  end
end
