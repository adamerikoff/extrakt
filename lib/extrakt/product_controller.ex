defmodule Extrakt.ProductController do
alias Extrakt.DB, as: DB

  def index(request) do
    items =
      DB.list_products()
      |> Enum.map(fn(item) -> "<li>#{item.name} - #{item.type} - #{item.in_stock}</li>" end)
      |> Enum.join

    %{ request | status_code: 200, response_body: "<ul>#{items}</ul>" }
  end

  def show(request, %{ "idx" => idx }) do
    product = DB.get_product(idx)
    %{ request | status_code: 200, response_body: "<h1>Product #{product.id}: #{product.name} - #{product.type}.</h1>" }
  end

  def create(request, %{ "name" => name, "type" => type }) do
    %{ request | status_code: 201, response_body: "Created a #{name}-#{type}!" }
  end
end
