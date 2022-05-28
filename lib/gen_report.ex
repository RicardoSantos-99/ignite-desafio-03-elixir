defmodule GenReport do
  alias GenReport.Parser

  @available_names [
    "cleiton",
    "daniele",
    "danilo",
    "diego",
    "giuliano",
    "jakeliny",
    "joseph",
    "mayk",
    "rafael",
    "vinicius"
  ]

  @available_months [
    "janeiro",
    "fevereiro",
    "março",
    "abril",
    "maio",
    "junho",
    "julho",
    "agosto",
    "setembro",
    "outubro",
    "novembro",
    "dezembro"
  ]

  def build do
    {:error, "Insira o nome de um arquivo"}
  end

  def build(filename) do
    filename
    |> Parser.parse_file()
    |> IO.inspect()
    |> Enum.reduce(
      report_acc(),
      fn line, report -> sum_values(line, report) end
    )
  end

  defp sum_values(
         [name, hours, _day, month, year],
         report
       ) do
    all_hours = report["all_hours"]
    hours_per_month = report["hours_per_month"]
    hours_per_year = report["hours_per_year"]

    all_hours = Map.put(all_hours, name, all_hours[name] + hours)

    hours_per_month =
      Map.put(
        hours_per_month,
        name,
        Map.put(
          hours_per_month[name],
          month,
          hours_per_month[name][month] + hours
        )
      )

    hours_per_year =
      Map.put(
        hours_per_year,
        name,
        Map.put(
          hours_per_year[name],
          year,
          hours_per_year[name][year] + hours
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
    hours_per_year = Enum.into(2016..2020, %{}, &{&1, 0})
    hours_per_month = Enum.into(@available_months, %{}, &{&1, 0})

    %{
      "all_hours" => all_hours,
      "hours_per_year" => Enum.into(@available_names, %{}, &{&1, hours_per_year}),
      "hours_per_month" => Enum.into(@available_names, %{}, &{&1, hours_per_month})
    }
  end
end
