defmodule Extrakt.ProductController do
  alias Extrakt.DB, as: DB

  @templates_folder Path.expand("../../templates", __DIR__)

  def index(context) do
    products = DB.list_products()

    render(context, "index.eex", products)
  end

  def show(context, %{ "idx" => idx }) do
    product = DB.get_product(idx)

    render(context, "show.eex", product)
  end

  def create(context, %{ "name" => name, "type" => type }) do
    %{ context | status_code: 201, response_body: "Created a #{name}-#{type}!" }
  end

  defp render(context, template, bindings \\ []) do
    content =
      @templates_folder
      |> Path.join(template)
      |> EEx.eval_file(bindings)

      %{ context | status_code: 200, response_body: content }
  end
end
