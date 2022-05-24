defmodule GenReport.Parser do
  def parse_file(filename) do
    filename
    |> File.stream!()
    |> Enum.map(fn line -> parse_line(line) end)
  end

  defp parse_line(line) do
    [hd | tail] =
      String.trim(line)
      |> String.split(",")

    [hd | Enum.map(tail, fn elem -> String.to_integer(elem) end)]
  end

  # defp handle_file({:ok, file_content}), do: file_content
  # defp handle_file({:err, _reason}), do: "Error while opening file"
end
