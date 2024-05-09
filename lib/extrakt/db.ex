defmodule Extrakt.DB do
  alias Extrakt.Product, as: Product

  def list_products do
    [
      %Product{id: 0, name: "Fanta 1l", type: "Drink", in_stock: true},
      %Product{id: 1, name: "Coca Cola 1l", type: "Drink", in_stock: true},
      %Product{id: 2, name: "Water 0.5l", type: "Drink", in_stock: false},
      %Product{id: 3, name: "Apple Juice 1l", type: "Drink", in_stock: true},
      %Product{id: 4, name: "Orange Juice 1l", type: "Drink", in_stock: true},
      %Product{id: 5, name: "Milk 1l", type: "Dairy", in_stock: true},
      %Product{id: 6, name: "Yogurt 500g", type: "Dairy", in_stock: true},
      %Product{id: 7, name: "Cheese 200g", type: "Dairy", in_stock: false},
      %Product{id: 8, name: "Bread 700g", type: "Bakery", in_stock: true},
      %Product{id: 9, name: "Croissants (pack of 6)", type: "Bakery", in_stock: true},
      %Product{id: 10, name: "Baguette", type: "Bakery", in_stock: false},
      %Product{id: 11, name: "Apples (1kg)", type: "Produce", in_stock: true},
      %Product{id: 12, name: "Bananas (1kg)", type: "Produce", in_stock: true},
      %Product{id: 13, name: "Oranges (1kg)", type: "Produce", in_stock: false},
      %Product{id: 14, name: "Potatoes (2kg)", type: "Produce", in_stock: true},
      %Product{id: 15, name: "Onions (1kg)", type: "Produce", in_stock: true},
      %Product{id: 16, name: "Tomatoes (1kg)", type: "Produce", in_stock: true},
      %Product{id: 17, name: "Chicken Breast (1kg)", type: "Meat", in_stock: true},
      %Product{id: 18, name: "Ground Beef (1kg)", type: "Meat", in_stock: true},
      %Product{id: 19, name: "Salmon Fillet (500g)", type: "Meat", in_stock: false},
      %Product{id: 20, name: "Eggs (dozen)", type: "Dairy", in_stock: true},
      %Product{id: 21, name: "Butter 250g", type: "Dairy", in_stock: true},
      %Product{id: 22, name: "Pasta 500g", type: "Dry Goods", in_stock: true},
      %Product{id: 23, name: "Rice 1kg", type: "Dry Goods", in_stock: true},
      %Product{id: 24, name: "Beans (canned)", type: "Canned Goods", in_stock: true},
      %Product{id: 25, name: "Soup (canned)", type: "Canned Goods", in_stock: true},
      %Product{id: 26, name: "Tofu 300g", type: "Vegetarian", in_stock: true},
      %Product{id: 27, name: "Lentils (dry)", type: "Dry Goods", in_stock: true},
      %Product{id: 28, name: "Oatmeal 500g", type: "Breakfast", in_stock: true},
      %Product{id: 29, name: "Cereal (box)", type: "Breakfast", in_stock: true},
      %Product{id: 30, name: "Coffee (ground)", type: "Beverages", in_stock: true},
      %Product{id: 31, name: "Tea (bags)", type: "Beverages", in_stock: true},
      %Product{id: 32, name: "Juice Boxes (pack of 10)", type: "Beverages", in_stock: true},
    ]
  end

  def get_product(idx) when is_integer(idx) do
    Enum.find(list_products(), fn(item) -> item.id == idx end)
  end

  def get_product(idx) when is_binary(idx) do
    idx |> String.to_integer |> get_product
  end
end
