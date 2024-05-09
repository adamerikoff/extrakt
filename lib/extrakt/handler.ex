defmodule Extrakt.Handler do
  alias Extrakt.Request, as: Request

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

  def route(%Request{ method: "GET", path: "/wildthings" } = request) do
    %{ request | status_code: 200, response_body: "Bears, Lions, Tigers" }
  end

  def route(%Request{ method: "GET", path: "/bears" } = request) do
    %{ request | status_code: 200, response_body: "Teddy, Smokey, Wilfried" }
  end

  def route(%Request{ method: "GET", path: "/bears/" <> idx } = request) do
    %{ request | status_code: 200, response_body: "Bear #{idx}!" }
  end

  def route(%Request{ method: "POST", path: "/bears"} = request) do
    %{ request | status_code: 201, response_body: "Created a #{request.params["name"]}!" }
  end

  def route(%Request{ method: "GET", path: "/about" } = request) do
    @pages_folder
    |> Path.join("about.html")
    |> File.read
    |> handle_file(request)
  end

  def route(%Request{ path: path } = request) do
    %{ request | status_code: 404, response_body: "No #{path} found!" }
  end

  def handle_file({ :ok, content }, request), do: %{ request | status_code: 200, response_body: content }
  def handle_file({ :error, :enoent }, request), do: %{ request | status_code: 404, response_body: "File not found!" }
  def handle_file({ :error, reason }, request), do: %{ request | status_code: 500, response_body: "File error: #{reason}!" }



  def format_response(%Request{} = request) do
    """
      HTTP/1.1 #{Request.full_status(request)}
      Content-Type: text/html
      Content-Length: #{String.length(request.response_body)}

      #{request.response_body}
    """
  end

end


request = """
  POST /bears HTTP/1.1
  HOST: example.com
  User-Agent: ExampleBrowser/1.0
  Accept: */*
  Content-Type: application/x-www-form-urlencoded
  Content-Length: 21


  name=lkfasfafjl&type=Brown
"""

response = Extrakt.Handler.handle(request)

IO.puts(response)
