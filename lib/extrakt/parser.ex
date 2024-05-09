defmodule Extrakt.Parser do
  alias Extrakt.Context, as: Context
  def parse(context) do
    [top, params_string] = String.split(context, "\n\n")
    [request_line | header_lines] =  String.split(top, "\n")
    [method, path, _] = String.trim(request_line) |> String.split(" ")
    headers = parse_headers(header_lines, %{})
    params = parse_params(headers["Content-Type"], params_string)

    %Context{
      method: method,
      path: path,
      params: params,
      headers: headers
    }
  end

  def parse_headers([head | tail], headers) do
    [key, value] = String.trim(head) |> String.split(": ")
    headers = Map.put(headers, key, value)
    parse_headers(tail, headers)
  end

  def parse_headers([], headers), do: headers

  def parse_params("application/x-www-form-urlencoded", params_string) do
    params_string |> String.trim |> URI.decode_query
  end

  def parse_params(_, _), do: %{}
end
