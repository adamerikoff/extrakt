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

    %{
      method: method,
      path: path,
      response_body: "",
      status_code: nil }
  end

  def log(request), do: IO.inspect(request)

  # def route(request) do
  #   route(request, request.method, request.path)
  # end

  def route(%{ method: "GET", path: "/wildthings" } = request) do
    %{ request | status_code: 200, response_body: "Bears, Lions, Tigers" }
  end

  def route(%{ method: "GET", path: "/bears" } = request) do
    %{ request | status_code: 200, response_body: "Teddy, Smokey, Wilfried" }
  end

  def route(%{ method: "GET", path: "/bears/" <> idx } = request) do
    %{ request | status_code: 200, response_body: "Bear #{idx}!" }
  end

  def route(%{ path: path } = request) do
    %{ request | status_code: 404, response_body: "No #{path} found!" }
  end

  def format_response(request) do
    """
      HTTP/1.1 #{request.status_code} #{status(request.status_code)}
      Content-Type: text/html
      Content-Length: #{String.length(request.response_body)}

      #{request.response_body}
    """
  end

  defp status(code) do
    %{
      200 => "OK",
      201 => "Created",
      401 => "Unauthorized",
      403 => "Forbidden",
      404 => "Not Found",
      500 => "Internal Server Error",
    }[code]
  end
end


request = """
  GET /bears/2 HTTP/1.1
  HOST: example.com
  User-Agent: ExampleBrowser/1.0
  Accept: */*

"""

response = Extrakt.Handler.handle(request)

IO.puts(response)
