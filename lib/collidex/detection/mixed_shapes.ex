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

  ## Examples
  iex(14)> MixedShapes.collision?(
  ...(14)>   Rect.make(-1.0, -1.0, 1.0, 1.0),
  ...(14)>   Polygon.make([{0.9,0}, {2,1}, {2,-1}])
  ...(14)> )
  {:collision, "todo"}
  iex(15)> MixedShapes.collision?(
  ...(15)>   Rect.make(-1.0, -1.0, 1.0, 1.0),
  ...(15)>   Polygon.make([{1.1,0}, {2,1}, {2,-1}])
  ...(15)> )
  false
  """
  def collision?(shape1, shape2, method \\ :accurate)
  def collision?(rect = %Rect{}, poly = %Polygon{}, method ) do
    Polygons.collision?(Polygon.make(rect), poly, method)
  end
  def collision?(poly = %Polygon{}, rect = %Rect{}, method ) do
    Polygons.collision?(poly, Polygon.make(rect), method)
  end

  @doc """
  Detect collisions between Rects and Circles by promoting Rects
  to polygons.

  ## Examples
  iex(7)> Collidex.Detection.MixedShapes.collision?(
  ...(7)>   Collidex.Geometry.Circle.make(0,0,1.0),
  ...(7)>   Collidex.Geometry.Rect.make(1,-1,2,1)
  ...(7)> )
  {:collision, "todo_provide_vector"}
  iex(8)> Collidex.Detection.MixedShapes.collision?(
  ...(8)>   Collidex.Geometry.Circle.make(0,0,1.0),
  ...(8)>   Collidex.Geometry.Rect.make(1.1,-1,2,1)
  ...(8)> )
  false
  """
  def collision?(rect = %Rect{}, circle = %Circle{}, method ) do
    collision?(Polygon.make(rect), circle, method)
  end
  def collision?(circle = %Circle{}, rect = %Rect{}, method ) do
    collision?(circle, Polygon.make(rect), method)
  end

  @doc """
  Detect collisions between Circles and Polygons. Requires
  a special case of the separating axis theorem.

  Method :fast and :accurate are ignored for circle-to-polygon
  collisions because there is only one axis to test.

  ## Examples

  iex(5)> Collidex.Detection.MixedShapes.collision?(
  ...(5)>   Collidex.Geometry.Circle.make(0,0,1.0),
  ...(5)>   Collidex.Geometry.Polygon.make([{0.9,0}, {2,1}, {2,-1}])
  ...(5)> )
  {:collision, "todo_provide_vector"}

  iex(6)> Collidex.Detection.MixedShapes.collision?(
  ...(6)>   Collidex.Geometry.Circle.make(0,0,1.0),
  ...(6)>   Collidex.Geometry.Polygon.make([{1.1,0}, {2,1}, {2,-1}])
  ...(6)> )
  false

  """
  def collision?(poly = %Polygon{}, circle = %Circle{}, _method) do
    collision?(circle, poly)
  end
  def collision?(circle = %Circle{}, poly = %Polygon{}, _method) do
    center = circle.center
    closest_vertex = poly.vertices
      |> Enum.sort_by(&(Vec2.length(Vec2.subtract(&1, center))))
      |> List.first
    close_vertex_axis = Vec2.subtract(center, closest_vertex)

    all_axes = [close_vertex_axis | Polygons.normals_of_polygon(poly)]

    if all_axes
      |> Enum.find(false, fn({axis_x, axis_y} = axis) ->

          IO.puts "Testing Axis:"
          IO.inspect axis
          # Make unit-length projection axes so the circle radius is meaningful
          len = Vec2.length(axis)
          unit_axis = {axis_x / len, axis_y / len}

          polygon_projected_bounds = poly.vertices
            |> Enum.map(&(Vec2.dot(&1, axis)))
            |> Enum.min_max

          projected_center = Vec2.dot(center, axis)
          circle_projected_bounds = {
            projected_center + circle.radius,
            projected_center - circle.radius,
          }

          if !Collidex.Detection.Polygons.overlap?([
            circle_projected_bounds,
            polygon_projected_bounds
          ]) do
            IO.puts "no collision"
            true
          else
            IO.puts "this axis overlaps"
            false
          end
    end) do
      false
    else
      { :collision, "todo_provide_vector" }
    end
  end
end
