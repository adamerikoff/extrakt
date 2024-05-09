defmodule Extrakt.Handler do
  alias Extrakt.ProductController, as: ProductController
  alias Extrakt.Context, as: Context

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

  def route(%Context{ method: "GET", path: "/products" } = context) do
    ProductController.index(context)
  end

  def route(%Context{ method: "GET", path: "/products/" <> idx } = context) do
    params = Map.put(context.params, "idx", idx)
    ProductController.show(context, params)
  end

  def route(%Context{ method: "POST", path: "/products"} = context) do
    ProductController.create(context, context.params)
  end

  def route(%Context{ method: "GET", path: "/about" } = context) do
    @pages_folder
    |> Path.join("about.html")
    |> File.read
    |> handle_file(context)
  end

  def route(%Context{ path: path } = context) do
    %{ context | status_code: 404, response_body: "No #{path} found!" }
  end

  def handle_file({ :ok, content }, context), do: %{ context | status_code: 200, response_body: content }
  def handle_file({ :error, :enoent }, context), do: %{ context | status_code: 404, response_body: "File not found!" }
  def handle_file({ :error, reason }, context), do: %{ context | status_code: 500, response_body: "File error: #{reason}!" }



  def format_response(%Context{} = context) do
    """
      HTTP/1.1 #{context.full_status(context)}
      Content-Type: text/html
      Content-Length: #{String.length(context.response_body)}

      #{context.response_body}
    """
  end

end


context = """
  GET /products/18 HTTP/1.1
  HOST: example.com
  User-Agent: ExampleBrowser/1.0
  Accept: */*
  Content-Type: application/x-www-form-urlencoded
  Content-Length: 21


"""

response = Extrakt.Handler.handle(context)

IO.puts(response)
