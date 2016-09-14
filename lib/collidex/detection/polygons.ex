defmodule Collidex.Detection.Polygons do
  @moduledoc """
  Detects collisions between polygons using the separating
  axis theorem.  Has two variants, :fast and :accurate.  :fast
  will miss a few rare tyes of collisions but is much faster.
  """

  alias Graphmath.Vec2
  alias Collidex.Geometry.Polygon
  alias Collidex.Utils

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
    axes_to_test = Utils.normals_of_edges(poly1)
      ++ Utils.normals_of_edges(poly2)
    if axes_to_test |> Enum.any?(&(!collision_on_axis?(&1, poly1, poly2))) do
      false
    else
      { :collision, "todo_provide_vector" }
    end
  end

  defp collision_on_axis?(axis, poly1, poly2) do
    collision = [poly1, poly2]
      |> Enum.map(&(&1.vertices))
      |> Enum.map(fn(vertices) ->
          Enum.map(vertices, &(Vec2.dot(&1, axis)))
        end)
      |> Enum.map(&(Enum.min_max(&1)))
      |> Utils.overlap?
    if collision do
       { :collision, "todo_provide_vector" }
    else
      false
    end
  end

end
