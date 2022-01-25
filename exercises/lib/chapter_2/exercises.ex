defmodule Chapter2.Exercises do
  @doc """
    Implement sum/1. This function should take in a list of numbers and
    return the sum of the list
  """
  def sum([]), do: 0
  def sum([h | t]), do: h + sum(t)

  @doc """
    Explore the Enum module and familiarize yourself with the various functions
  """
  def enum_example_1, do: Enum.filter([1, 2, 3, 4, 5], &(&1 > 3))
  def enum_example_2, do: Enum.find([1, 2, 3, 4, 5], &(&1 > 3))
  def enum_example_3, do: Enum.count([1, 2, 3, 4, 5], &(&1 > 3))
  def enum_example_4, do: Enum.sum([1, 2, 3, 4, 5])

  @doc """
    Transform [1, [[2], 3]] to [9, 4, 1] with and without the pipe operator
  """
  def transform_without_pipe do
    correct_list = List.flatten([1, [[2], 3]])
    reverse_list = Enum.reverse(correct_list)
    Enum.map(reverse_list, fn n -> n * n end)
  end

  def transform_with_pipe do
    [1, [[2], 3]]
    |> List.flatten()
    |> Enum.reverse()
    |> Enum.map(&(&1 * &1))
  end

  @doc """
    Translate crypto:md5("Tales from the Crypt"). from Erlang to Elixir
  """
  def crypto_message do
    :crypto.hash(:md5, "Tales from the Crypt")
  end

end
