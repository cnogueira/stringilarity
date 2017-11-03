defmodule StringilarityTest do
  use ExUnit.Case
  doctest Stringilarity

  test "sorensen-dice similarity coefficient" do
    assert Stringilarity.dice("night", "nocht", 1) == 0.6
    assert Stringilarity.dice("context", "contact", 1) == 0.7142857142857143
    assert Stringilarity.dice("go", "gogogogo") == 0.25
  end

  test "sorensen-dice similarity coefficient works with digrams by default" do
    assert Stringilarity.dice("whatever", "whomever") == Stringilarity.dice("whatever", "whomever", 2)
  end

  test "sorensen-dice similrity coefficient is case insensitive" do
    assert Stringilarity.dice("night", "nocht") == Stringilarity.dice("NIGHT", "nocht")
  end
end
