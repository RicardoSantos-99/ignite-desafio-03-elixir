defmodule GenReport do
  alias GenReport.Parser

  def build(filename) do
    filename
    |> Parser.parse_file()
  end
end
