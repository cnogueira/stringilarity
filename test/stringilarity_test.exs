defmodule StringilarityTest do
  use ExUnit.Case
  doctest Stringilarity

  test "sorensen-dice similarity coefficient" do
    assert Stringilarity.dice("context", "contact", 1) == 0.7142857142857143
    assert Stringilarity.dice("go", "gogogogo") == 0.25
  end

  test "sorensen-dice similarity coefficient works with digrams by default" do
    assert Stringilarity.dice("whatever", "whomever") == Stringilarity.dice("whatever", "whomever", 2)
  end

  test "sorensen-dice similarity coefficient is case insensitive" do
    assert Stringilarity.dice("night", "nocht") == Stringilarity.dice("NIGHT", "nocht")
  end

  test "jaccard similarity coefficient" do
    assert Stringilarity.jaccard("night", "nocht", 1) |> Float.floor(5) == 0.42857
    assert Stringilarity.jaccard("context", "contact", 1) |> Float.floor(5) == 0.55555
    assert Stringilarity.jaccard("go", "gogogogo") |> Float.floor(5) == 0.14285
  end

  test "jaccard similarity coefficient works with digrams by default" do
    assert Stringilarity.jaccard("whatever", "whomever") == Stringilarity.jaccard("whatever", "whomever", 2)
  end

  test "jaccard similarity coefficient is case insensitive" do
    assert Stringilarity.jaccard("night", "nocht") == Stringilarity.jaccard("NIGHT", "nocht")
  end
end
