defmodule Collidex.ListDetector do
  @moduledoc """
  Functions responsible for testing lists of geometric primitives for
  collisions.
  """

  @doc """
  Given two lists `list1` and `list2`, will return a list of collisions
  found between any shapes in list1 and any shapes in list2.
  """
  def find_collisions(list1, list2, method \\ :accurate )
  def find_collisions(list1, list2, method) do
    []
  end
end
