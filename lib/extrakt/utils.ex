defmodule Extrakt.Utils do
  alias Extrakt.Request, as: Request
  def track(%Request{ status_code: 404, path: path } = request) do
    IO.puts "Warning: #{path} doesn't exist!"
    request
  end

  def track(%Request{} = request), do: request

  def rewrite_path(%Request{ path: "/items" } = request) do
    %{ request| path: "/products" }
  end

  def rewrite_path(%Request{} = request), do: request

  def log(%Request{} = request), do: IO.inspect request
end
