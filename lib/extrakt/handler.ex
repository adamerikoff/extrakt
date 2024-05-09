defmodule Extrakt.Handler do
  @pages_folder Path.expand("../../pages", __DIR__)

  def handle(request) do
    request
    |> Extrakt.Parser.parse
    |> Extrakt.Utils.rewrite_path
    |> Extrakt.Utils.log
    |> route
    |> Extrakt.Utils.track
    |> format_response
  end

  def route(%{ method: "GET", path: "/wildthings" } = request) do
    %{ request | status_code: 200, response_body: "Bears, Lions, Tigers" }
  end

  def route(%{ method: "GET", path: "/bears" } = request) do
    %{ request | status_code: 200, response_body: "Teddy, Smokey, Wilfried" }
  end

  def route(%{ method: "GET", path: "/bears/" <> idx } = request) do
    %{ request | status_code: 200, response_body: "Bear #{idx}!" }
  end

  def route(%{ method: "GET", path: "/about" } = request) do
    @pages_folder
    |> Path.join("about.html")
    |> File.read
    |> handle_file(request)
  end

  def route(%{ path: path } = request) do
    %{ request | status_code: 404, response_body: "No #{path} found!" }
  end

  def handle_file({ :ok, content }, request), do: %{ request | status_code: 200, response_body: content }
  def handle_file({ :error, :enoent }, request), do: %{ request | status_code: 404, response_body: "File not found!" }
  def handle_file({ :error, reason }, request), do: %{ request | status_code: 500, response_body: "File error: #{reason}!" }



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
  GET /about HTTP/1.1
  HOST: example.com
  User-Agent: ExampleBrowser/1.0
  Accept: */*

"""

response = Extrakt.Handler.handle(request)

IO.puts(response)
