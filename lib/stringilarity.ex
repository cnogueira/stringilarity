defmodule Stringilarity do
  @moduledoc """
  Collection of measurement of string similarity/distance functions.
  """

  @doc """
  Computes the Sorensen-dice similarity coefficient

  ## Examples

    iex> Stringilarity.dice("night", "nocht")
    0.25

    iex> Stringilarity.dice("NIGHT", "nocht", 1)
    0.6

  """
  def dice(a, b, ngram_size \\ 2) do
    ngrams_a = a |> to_ngram_frequency_map(ngram_size)
    ngrams_b = b |> to_ngram_frequency_map(ngram_size)
    ngrams_common_count = count_intersect_freq(ngrams_a, ngrams_b)

    2 * ngrams_common_count / (count_freq(ngrams_a) + count_freq(ngrams_b))
  end

  @doc """
  Computes the Jaccard similarity coefficient

  ## Examples

    iex> Stringilarity.jaccard("Owl", "boWlinG")
    0.3333333333333333

    iex> Stringilarity.jaccard("Owl", "boWlinG", 1)
    0.4285714285714286

  """
  def jaccard(a, b, ngram_size \\ 2) do
    dice_coeff = dice(a, b, ngram_size)

    dice_coeff / (2 - dice_coeff)
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

    tail
    |> n_grams_frequency_map(ngram_size)
    |> Map.update(ngram, 1, & &1 + 1)
  end

  # Computes the intersection of two frequency maps, counting for each element
  # the amount it appears in both sets
  defp count_intersect_freq(a, b) when map_size(a) > map_size(b), do: count_intersect_freq(b, a)
  defp count_intersect_freq(freq_a, freq_b) do
    map_function = fn {key, freq}, acc ->
      acc + min(freq, Map.get(freq_b, key, 0))
    end

    Enum.reduce(freq_a, 0, map_function)
  end

  defp count_freq(freq_map) do
    Enum.reduce(freq_map, 0, fn {_, freq}, acc -> acc + freq end)
  end
end
