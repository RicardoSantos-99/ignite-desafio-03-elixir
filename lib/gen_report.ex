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

  @available_months [
    "Janeiro",
    "Fevereiro",
    "Março",
    "Abril",
    "Maio",
    "Junho",
    "Julho",
    "Agosto",
    "Setembro",
    "Outubro",
    "Novembro",
    "Dezembro"
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
         [name, hours, day, month, year],
         report
       ) do
    IO.inspect(report)

    name_list = report["all_hours"]
    year_list = report["hours_per_year"]
    months_index = report["hours_per_month"]

    all_hours = Map.put(name_list, name, name_list[name] + hours)

    hours_per_month =
      Map.put(
        months_index,
        name,
        Map.put(
          months_index[name],
          month,
          months_index[name][month] + hours
        )
      )

    hours_per_year =
      Map.put(
        year_list,
        name,
        Map.put(
          year_list[name],
          year,
          year_list[name][year] + hours
        )
      )

    %{
      "all_hours" => all_hours,
      "hours_per_month" => hours_per_month,
      "hours_per_year" => hours_per_year
    }
  end

  def report_acc do
    all_hours = Enum.into(@available_names, %{}, &{&1, 0})
    hours_per_month = Enum.into(1..12, %{}, &{&1, 0})
    hours_per_year = Enum.into(2016..2020, %{}, &{&1, 0})

    hours_per_month = Enum.into(@available_names, %{}, &{&1, hours_per_month})
    hours_per_year = Enum.into(@available_names, %{}, &{&1, hours_per_year})

    %{
      "all_hours" => all_hours,
      "hours_per_month" => hours_per_month,
      "hours_per_year" => hours_per_year
    }
  end
end
