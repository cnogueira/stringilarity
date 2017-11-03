defmodule StringilarityTest do
  use ExUnit.Case
  doctest Stringilarity

  test "sorensen-dice similarity coefficient" do
    assert Stringilarity.dice("night", "nocht") == 0.25
  end
end
