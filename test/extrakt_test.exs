defmodule ExtraktTest do
  use ExUnit.Case
  doctest Extrakt

  test "greets the world" do
    assert Extrakt.hello() == :world
  end
end
