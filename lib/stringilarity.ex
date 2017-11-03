defmodule Stringilarity do

  @doc """
  Computes the Sorensen-dice similarity coefficient

  ## Examples

    iex> Stringilarity.dice("night", "nocht")
    0.25

  """
  def dice(a, b) do
    bigrams_a = a |> to_bigram_set
    bigrams_b = b |> to_bigram_set
    common_bigrams = MapSet.intersection(bigrams_a, bigrams_b)

    2*MapSet.size(common_bigrams) / (MapSet.size(bigrams_a) + MapSet.size(bigrams_b))
  end

  defp to_bigram_set(word) do
    word
    |> String.codepoints
    |> n_grams(2)
    |> MapSet.new
  end

  defp n_grams(list, n) when length(list) < n, do: []
  defp n_grams([_head | tail] = list, n) do
    ngram = list |> Enum.take(n) |> List.to_string

    [ngram | n_grams(tail, n)]
  end
end
