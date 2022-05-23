defmodule GenReport.Parser do
  def parse_file(filename) do
    filename
    |> File.read()
    |> handle_file()

    # |> Stream.map(fn line -> parse_line(line) end)
  end

  # defp parse_line(line) do
  #   line
  #   |> String.trim()
  #   |> String.split(",")
  # end

  defp handle_file({:ok, file_content}), do: file_content
  defp handle_file({:err, _reason}), do: "Error while opening file"
end
