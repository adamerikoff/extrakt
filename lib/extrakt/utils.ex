defmodule Extrakt.Utils do
  def track(%{ status: 404, path: path } = request) do
    IO.puts "Warning: #{path} doesn't exist!"
    request
  end

  def track(request), do: request

  def rewrite_path(%{ path: "/wildlife" } = request) do
    %{ request| path: "/wildthings" }
  end

  def rewrite_path(request), do: request

  def log(request), do: IO.inspect request
end
