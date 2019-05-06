defmodule DoApiTest do
  use ExUnit.Case
  doctest DoApi

  test "greets the world" do
    assert DoApi.hello() == :world
  end
end
