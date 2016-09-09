defmodule Collidex.Detection.PolySAT do
  @moduledoc """
  Detects collisions between polygons using the separating
  axis theorem.  Has two variants, :fast and :accurate.  :fast
  will miss a few rare tyes of collisions but is much faster.
  """

  alias Graphmath.Vec2
  alias Collidex.Geometry.Polygon

  @doc """
  Given two variables, determine if they appear to collide,
  based on a single test along their centroid-to-centroid axis.

  This will report some false positives among nearly-colliding
  polygons, but should be accurate enough for most game-related work.
  """
  def collision?(poly1, poly2, :fast) do
    axis = Vec2.subtract(Polygon.center(poly2), Polygon.center(poly1))
    collision = [poly1, poly2]
      |> Enum.map(&(&1.vertices))
      |> Enum.map(fn(vertices) ->
          Enum.map(vertices, &(Vec2.dot(&1, axis)))
        end)
      |> Enum.map(&(Enum.min_max(&1)))
      |> overlap?
    if collision do
       { :collision, "foo" }
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
