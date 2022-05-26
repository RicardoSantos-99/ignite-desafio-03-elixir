defmodule GenReport do
  alias GenReport.Parser

  def build(filename) do
    filename
    |> Parser.parse_file()

    # |> Enum.reduce(report_acc(), fn line, report -> sum_values(line, report) end)
  end
end
