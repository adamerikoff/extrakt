defmodule Extrakt.Parser do
  def parse(request) do
    [method, path, _] =
      request
      |> String.split("\n")
      |> List.first
      |> String.trim
      |> String.split(" ")

    %{
      method: method,
      path: path,
      response_body: "",
      status_code: nil }
  end
end
