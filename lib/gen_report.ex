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

  defp sum_values([name, hours, _day, _month, _year], report) do
    Map.put(report, name, report[name] + hours)
  end

  def report_acc do
    names = Enum.into(@available_names, %{}, &{&1, 0})
    days = Enum.into(1..30, %{}, &{&1, 0})
    hours = Enum.into(1..8, %{}, &{&1, 0})
    months = Enum.into(1..12, %{}, &{&1, 0})
    years = Enum.into(2016..2020, %{}, &{&1, 0})

    %{
      "names" => names,
      "days" => days,
      "hours" => hours,
      "months" => months,
      "years" => years
    }
  end
end
