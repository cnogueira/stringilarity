defmodule Stringilarity do

  @doc """
  Computes the Sorensen-dice similarity coefficient

  ## Examples

    iex> Stringilarity.dice("night", "nocht")
    0.25

  """
  def dice(a, b, ngram_size \\ 2) do
    ngrams_a = a |> to_ngram_frequency_map(ngram_size)
    ngrams_b = b |> to_ngram_frequency_map(ngram_size)
    ngrams_common_count = count_intersect_freq(ngrams_a, ngrams_b)

    2*ngrams_common_count / (count_freq(ngrams_a) + count_freq(ngrams_b))
  end

  defp to_ngram_frequency_map(word, ngram_size) do
    word
    |> String.downcase
    |> String.codepoints
    |> n_grams_frequency_map(ngram_size)
  end

  defp n_grams_frequency_map(list, ngram_size) when length(list) < ngram_size, do: %{}
  defp n_grams_frequency_map([_head | tail] = list, ngram_size) do
    ngram = list |> Enum.take(ngram_size) |> List.to_string

    n_grams_frequency_map(tail, ngram_size)
    |> Map.update(ngram, 1, & &1+1)
  end

  # Computes the intersection of two frequency maps, counting for each element
  # the amount it appears in both sets
  defp count_intersect_freq(a, b) when map_size(a) > map_size(b), do: count_intersect_freq(b, a)
  defp count_intersect_freq(freq_a, freq_b) do
    Enum.reduce(freq_a, 0, fn {key, freq}, acc -> acc + min(freq, Map.get(freq_b, key, 0)) end)
  end

  defp count_freq(freq_map) do
    Enum.reduce(freq_map, 0, fn {_, freq}, acc -> acc + freq end)
  end
end
