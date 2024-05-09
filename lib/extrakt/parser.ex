defmodule Extrakt.Parser do
  alias Extrakt.Request, as: Request
  def parse(request) do
    [top, params_string] = String.split(request, "\n\n")
    [request_line | _header_lines] =  String.split(top, "\n")
    [method, path, _] = String.trim(request_line) |> String.split(" ")
    params = parse_params(params_string)

    %Request{
      method: method,
      path: path,
      params: params
    }
  end

  def parse_params(params_string) do
    params_string |> String.trim |> URI.decode_query
  end
end