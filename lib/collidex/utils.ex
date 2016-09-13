defmodule Collidex.Utils do
  @moduledoc """
  Assorted utilities and geometric transformations.
  """
  alias Collidex.Geometry.Polygon
  alias Graphmath.Vec2

  @doc """
  Returns a vector normal to each edge of the shape, in a right-handed
  coordinate space.
  """
  def normals_of_edges(shape = %Polygon{}) do
    { _, sides } = shape.vertices
      |> Enum.reduce( {List.last(shape.vertices), []},
        fn (vertex, {prev, list}) ->
          {vertex, [ Vec2.subtract(vertex, prev) | list] }
        end )
    sides |> Enum.map(&(Vec2.perp(&1)))
  end


  @doc """
  Convert the numeric parts of arguments to floats.  Accepts
  a single number, a 2-tuple of numbers, or a list of 2-tuples
  of numbers.

  ## Examples
  iex> Collidex.Utils.coerce_floats [ {1, 3}, {-1.5, -2} ]
  [ {1.0, 3.0}, {-1.5, -2.0} ]

  iex> Collidex.Utils.coerce_floats {1, 3}
  {1.0, 3.0}

  iex> Collidex.Utils.coerce_floats 6
  6.0
  """
  def coerce_floats(list) when is_list(list) do
    list |> Enum.map(fn({a, b}) -> { a/1, b/1}  end)
  end
  def coerce_floats({a, b}) do
    { a / 1, b / 1 }
  end
  def coerce_floats(num) do
    num / 1
  end
end
