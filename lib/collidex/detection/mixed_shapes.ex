defmodule Collidex.Detection.MixedShapes do
  @moduledoc """
  Handles detection of collisions between disparate shapes. (i.e. Rects
  and Circles, Rects and Polygons, Polygons and Circles)
  """

  alias Collidex.Geometry.Rect
  alias Collidex.Geometry.Circle
  alias Collidex.Geometry.Polygon
  alias Graphmath.Vec2

  alias Collidex.Detection.Polygons

  @doc """
  Detect collisions between Rects and Polygons by promoting
  Rects to polygons.

  TODO: Test if a special case treatment of rects-to-polygons
  without promoting the rects has sufficiently better performance
  to justify it.
  """
  def collision?(shape1, shape2, method \\ :accurate)
  def collision?(rect = %Rect{}, poly = %Polygon{}, method ) do
    Polygons.collision?(Polygon.make(rect), poly, method)
  end
  def collision?(poly = %Polygon{}, rect = %Rect{}, method ) do
    Polygons.collision?(poly, Polygon.make(rect), method)
  end

  @doc """
  Detect collisions between Circles and Polygons. Requires
  a special case of the separating axis theorem.

  Method :fast and :accurate are ignored for circle-to-polygon
  collisions because there is only one axis to test.
  """
  def collision?(poly = %Polygon{}, circle = %Circle{}, _method) do
    collision?(circle, poly)
  end
  def collision?(circle = %Circle{}, poly = %Polygon{}, _method) do
    center = circle.center
    closest = poly.vertices
      |> Enum.sort_by(&(Vec2.length(Vec2.subtract(&1, center))))
      |> List.first
    { ax, ay} = Vec2.subtract(center, closest)

    # Make a unit-length projection axis so the circle radius is meaningful
    axis = { ax / Vec2.length({ax, ay}), ay / Vec2.length({ax, ay}) }

    polygon_projected_bounds = poly.vertices
      |> Enum.map(&(Vec2.dot(&1, axis)))
      |> Enum.min_max

    projected_center = Vec2.dot(center, axis)
    circle_projected_bounds = {
      projected_center + circle.radius,
      projected_center - circle.radius,
    }

    # TODO refactor into utility module
    if Collidex.Detection.Polygons.overlap?([
      circle_projected_bounds,
      polygon_projected_bounds
    ]) do
      { :collision, "todo_provide_vector"}
    else
      false
    end
  end


end
