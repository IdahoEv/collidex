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
  alias Collidex.Utils

  @doc """
  Check for collisions between any two shapes not of the same type.  Return
  value is truthy if the shapes overlap on the plane.

  `method` defaults to :accurate and is ignored if any of the shapes
  are circles. See Collidex.Detection.Polygons for an explanation of
  `method`.

  ## Examples

  ```
  iex> Collidex.Detection.MixedShapes.collision?(
  ...>   Collidex.Geometry.Rect.make(-1.0, -1.0, 1.0, 1.0),
  ...>   Collidex.Geometry.Polygon.make([{0.9,0}, {2,1}, {2,-1}])
  ...> )
  { :collision, "todo_provide_vector"}

  iex> Collidex.Detection.MixedShapes.collision?(
  ...>   Collidex.Geometry.Rect.make(-1.0, -1.0, 1.0, 1.0),
  ...>   Collidex.Geometry.Polygon.make([{1.1,0}, {2,1}, {2,-1}])
  ...> )
  false

  iex> Collidex.Detection.MixedShapes.collision?(
  ...>   Collidex.Geometry.Circle.make(0,0,1.0),
  ...>   Collidex.Geometry.Rect.make(1,-1,2,1)
  ...> )
  { :collision, "todo_provide_vector" }

  iex> Collidex.Detection.MixedShapes.collision?(
  ...>   Collidex.Geometry.Circle.make(0,0,1.0),
  ...>   Collidex.Geometry.Rect.make(1.1,-1,2,1)
  ...> )
  false

  iex> Collidex.Detection.MixedShapes.collision?(
  ...>   Collidex.Geometry.Circle.make(0,0,1.0),
  ...>   Collidex.Geometry.Polygon.make([{0.9,0}, {2,1}, {2,-1}])
  ...> )
  { :collision, "todo_provide_vector"}

  iex> Collidex.Detection.MixedShapes.collision?(
  ...>   Collidex.Geometry.Circle.make(0,0,1.0),
  ...>   Collidex.Geometry.Polygon.make([{1.1,0}, {2,1}, {2,-1}])
  ...> )
  false

  ```
  """
  def collision?(shape1, shape2, method \\ :accurate)
  def collision?(rect = %Rect{}, poly = %Polygon{}, method ) do
    # TODO: Test if a special case treatment of rects-to-polygons
    # without promoting the rects has sufficiently better performance
    # to justify it.
    Polygons.collision?(Polygon.make(rect), poly, method)
  end
  def collision?(poly = %Polygon{}, rect = %Rect{}, method ) do
    Polygons.collision?(poly, Polygon.make(rect), method)
  end

  def collision?(rect = %Rect{}, circle = %Circle{}, method ) do
    collision?(Polygon.make(rect), circle, method)
  end
  def collision?(circle = %Circle{}, rect = %Rect{}, method ) do
    collision?(circle, Polygon.make(rect), method)
  end
  def collision?(poly = %Polygon{}, circle = %Circle{}, _method) do
    collision?(circle, poly)
  end
  def collision?(circle = %Circle{}, poly = %Polygon{}, _method) do
    center = circle.center
    closest_vertex = poly.vertices
      |> Enum.sort_by(&(Vec2.length(Vec2.subtract(&1, center))))
      |> List.first

    close_vertex_axis = Vec2.subtract(center, closest_vertex)
    all_axes = [close_vertex_axis | Utils.normals_of_edges(poly)]

    if all_axes
      |> Enum.find(false, fn({axis_x, axis_y}) ->
        # Make unit-length projection axes so the circle radius is meaningful
        unit_axis = Utils.unit_vector({axis_x, axis_y})

        polygon_projection = Utils.extent_on_axis(poly, unit_axis)
        circle_projection = Utils.extent_on_axis(circle, unit_axis)

        !Utils.overlap?(circle_projection, polygon_projection)
    end) do
      false
    else
      { :collision, "todo_provide_vector" }
    end
  end
end
