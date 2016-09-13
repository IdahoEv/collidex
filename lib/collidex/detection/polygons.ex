defmodule Collidex.Detection.Polygons do
  @moduledoc """
  Detects collisions between polygons using the separating
  axis theorem.  Has two variants, :fast and :accurate.  :fast
  will miss a few rare tyes of collisions but is much faster.
  """

  alias Graphmath.Vec2
  alias Collidex.Geometry.Polygon

  @doc """
  Determine if two polygons are colliding. Uses the separating
  Axis Theorem, and so can only perform accurate detection for
  convex polygons.

  if :fast is passed as the third argument, this function will use the
  shortcut method of only checking one axis: the centroid-to-centroid
  axis. This method is faster (at least as fast, with much better worst-case
  performance) and will correctly detect the vast  majority of collisions,
  but will occasionally return a false positive for almost-colliding acute
  polygons (particularly triangles) at skew angles.
  """
  def collision?(poly1, poly2, type \\ :accurate)


  def collision?(poly1, poly2, :fast) do
    Vec2.subtract(Polygon.center(poly2), Polygon.center(poly1))
      |> collision_on_axis?(poly1, poly2)
  end

  def collision?(poly1, poly2, :accurate) do
    axes_to_test = normals_of_polygon(poly1)
      ++ normals_of_polygon(poly2)
    if axes_to_test |> Enum.any?(&(!collision_on_axis?(&1, poly1, poly2))) do
      false
    else
      { :collision, "todo_provide_vector" }
    end
  end

  def normals_of_polygon(poly) do
    { _, sides } = poly.vertices
      |> Enum.reduce( {List.last(poly.vertices), []},
        fn (vertex, {prev, list}) ->
          {vertex, [ Vec2.subtract(vertex, prev) | list] }
        end )
    sides |> Enum.map(&(Vec2.perp(&1)))
  end

  defp collision_on_axis?(axis, poly1, poly2) do
    collision = [poly1, poly2]
      |> Enum.map(&(&1.vertices))
      |> Enum.map(fn(vertices) ->
          Enum.map(vertices, &(Vec2.dot(&1, axis)))
        end)
      |> Enum.map(&(Enum.min_max(&1)))
      |> overlap?
    if collision do
       { :collision, "todo_provide_vector" }
    else
      false
    end
  end


  def overlap?([{min1, max1}, {min2, max2}]) do
    in_range?(min1, min2, max2)
      or in_range?(max1, min2, max2)
      or in_range?(min2, min1, max1)
      or in_range?(max2, min1, max1)
  end

  defp in_range?(a,b,c) when b > c do
    in_range?(a,c,b)
  end

  defp in_range?(a,b,c) do
    a >= b and a <= c
  end

end
