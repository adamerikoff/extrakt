defmodule Extrakt.Utils do
  alias Extrakt.Context, as: Context
  def track(%Context{ status_code: 404, path: path } = context) do
    IO.puts "Warning: #{path} doesn't exist!"
    context
  end

  def track(%Context{} = context), do: context

  def rewrite_path(%Context{ path: "/items" } = context) do
    %{ context| path: "/products" }
  end

  def rewrite_path(%Context{} = context), do: context

  def log(%Context{} = context), do: IO.inspect context
end
