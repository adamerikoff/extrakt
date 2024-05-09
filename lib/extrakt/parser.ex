defmodule Extrakt.Parser do
  alias Extrakt.Request, as: Request
  def parse(request) do
    [method, path, _] =
      request
      |> String.split("\n")
      |> List.first
      |> String.trim
      |> String.split(" ")

    %Request{
      method: method,
      path: path
    }
  end
end
