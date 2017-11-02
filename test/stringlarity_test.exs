defmodule StringlarityTest do
  use ExUnit.Case
  doctest Stringlarity

  test "greets the world" do
    assert Stringlarity.hello() == :world
  end
end
