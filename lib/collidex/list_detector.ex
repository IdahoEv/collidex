defmodule Collidex.ListDetector do
  @moduledoc """
  Functions responsible for testing lists of geometric primitives for
  collisions.
  """

  @doc """
  Given two lists `list1` and `list2`, find any collisions
  found between shapes in list1 and any shapes in list2.

  Return value is a list of 3-tuples `{ shape_1, shape_2, _ }`
  where 'shape_1' is the geometry from 'list_1' that overlaps with 'shape_2'
  from 'list_2', and the third member of the tuple is undefined for now
  but will eventually be the vector from 'shape_1' to 'shape_2'.

  ## Examples

  iex> c1 = Collidex.Geometry.Circle.make(0.0, 0.0, 1.0)
  iex> r1 = Collidex.Geometry.Rect.make({0.5, -1.0}, {1.5, 1.0})
  iex> r2 = Collidex.Geometry.Rect.make({1.5, -1.0}, {2.5, 1.0})
  iex> Collidex.ListDetector.find_collisions([c1], [r1, r2]) == [
  ...>   { c1, r1, "todo_provide_vector" } ]
  true
  """
  def find_collisions(list_1, list_2, method \\ :accurate )
  def find_collisions(list_1, list_2, method)
    when is_list(list_1) and is_list(list_2) do
    for shape_1 <- list_1,
        shape_2 <- list_2,
        return_val = Collidex.Detector.collision?(shape_1, shape_2, method) do
      { :collision, vector } = return_val
      { shape_1, shape_2, vector }
    end
  end

  def find_collisions_within(list, method \\ :accurate)
  def find_collisions_within([], method) do
    []
  end
  def find_collisions_within([head | tail], method) do
    find_collisions([head], tail, method) ++
      find_collisions_within(tail, method)
  end

  # def find_collisions_within(item, list, method \\ :accurate)
  # def find_collisions_within(item, [], _) do
  #   []
  # end
  # def find_collisions_within(item, list, method) do
  #   [ head | tail ] = list
  #   find_collisions([item], list, method) ++
  #     find_collisions_within(head, tail, method)
  # end

end
