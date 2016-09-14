defmodule Collidex.Utils do
  @moduledoc """
  Assorted utilities and geometric transformations.
  """
  alias Collidex.Geometry.Polygon
  alias Collidex.Geometry.Rect
  alias Collidex.Geometry.Circle
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
  Given two numeric ranges as a pair of 2-tuples `{a1, a2}, {b1, b2}`, or
  a list containing a pair of 2-tuples `[{a1, a2}, {b1, b2}]` returns
  true if those ranges overlap.

  ## Examples

  ```
  iex> Collidex.Utils.overlap?({0.0,5.0}, {5.0, 10.0})
  true

  iex> Collidex.Utils.overlap?({-1.0, -3.0}, {-6.1, 3.5})
  true

  iex> Collidex.Utils.overlap?({-1.0, 0.0}, {0.01, 1.0} )
  false

  ```
  """
  def overlap?({min1, max1}, {min2, max2}) do
    in_range?(min1, min2, max2)
      or in_range?(max1, min2, max2)
      or in_range?(min2, min1, max1)
      or in_range?(max2, min1, max1)
  end
  def overlap?([tuple1, tuple2]) do
    overlap?(tuple1, tuple2)
  end

  @doc """
  Find the projection of the vertices of a shape (Rect or Polygon)
  on an arbitrary axis.  Returns a list of floats representing
  the projection of each vertex.
  """
  def project_onto_axis(poly = %Polygon{}, axis ) do
    poly.vertices |> Enum.map(&(Vec2.dot(&1,axis)))
  end
  def project_onto_axis(r = %Rect{}, axis) do
    project_onto_axis(Polygon.make(r), axis)
  end


  @doc """
  Find the minimum and maximum point of a shape, as that shape is
  projected along an arbitrary axis. Supports Rects, Circles, and Polygons,
  but note that the projection of a Circle will only be accurate if
  the axis of projection is a unit vector.

  Returns a 2-tuple representing the minimum and maximum point of the
  shape's "shadow" as projected onto `axis`.
  """
  def extent_on_axis(circle = %Circle{}, axis) do
    # TODO raise an exception if this isn't a unit vector axis
    projected_center = Vec2.dot(circle.center, axis)
    { projected_center - circle.radius,
      projected_center + circle.radius }
  end
  def extent_on_axis(shape, axis ) do
    project_onto_axis(shape, axis) |> Enum.min_max
  end

  @doc """
  Returns a unit-vector in the same direction as the
  argument.
  """
  def unit_vector({x,y}) do
    len = Vec2.length({x,y})
    {x / len, y / len}
  end

  @doc """
  Convert the numeric parts of arguments to floats.  Accepts
  a single number, a 2-tuple of numbers, or a list of 2-tuples
  of numbers.

  ## Examples

  ```
  iex> Collidex.Utils.coerce_floats [ {1, 3}, {-1.5, -2} ]
  [ {1.0, 3.0}, {-1.5, -2.0} ]

  iex> Collidex.Utils.coerce_floats {1, 3}
  {1.0, 3.0}

  iex> Collidex.Utils.coerce_floats 6
  6.0

  ```
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

  defp in_range?(a,b,c) when b > c do
    in_range?(a,c,b)
  end
  defp in_range?(a,b,c) do
    a >= b and a <= c
  end
end
