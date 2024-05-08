defmodule Extrakt.Handler do
  def handle(request) do
    request
    |> parse
    |> log
    |> route
    |> format_response
  end

  def parse(request) do
    [method, path, _] =
      request
      |> String.split("\n")
      |> List.first
      |> String.trim
      |> String.split(" ")

    %{ method: method, path: path, response_body: "" }
  end

  def log(request), do: IO.inspect(request)

  def route(request) do
    %{ request |  response_body: "Bears, Lions, Tigets" }
  end

  def format_response(request) do
    """
      HTTP/1.1 200 OK
      Content-Type: text/html
      Content-Length: #{String.length(request.response_body)}

      #{request.response_body}
    """
  end
end


request = """
  GET /wildthings HTTP/1.1
  HOST: example.com
  User-Agent: ExampleBrowser/1.0
  Accept: */*

"""

response = Extrakt.Handler.handle(request)

IO.puts(response)
