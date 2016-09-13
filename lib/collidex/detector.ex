defmodule Collidex.Detector do
  @moduledoc """
  Main module responsible for detecting whether two
  particular pieces of geometry have collided.  All actual
  detections are delegated to functions in Collidex.Detection.*
  modules; this module effectively just routes geometry to the
  correct detection function.
  """

  alias Collidex.Geometry.Circle
  alias Collidex.Geometry.Rect
  alias Collidex.Geometry.Polygon
  alias Collidex.Detection.Circles
  alias Collidex.Detection.Rects
  alias Collidex.Detection.Polygons
  alias Collidex.Detection.MixedShapes


  @doc """
  Determine if two shapes collide on the plane.  If the two shapes do not
  overlap, the return value will be falsy.  If they do overlap,
  it will return { :collision, _ }.  (The second member
  of the tuple will eventually be the vector along which the two shapes
  are colliding, but that is not implented yet).

  The optional third argument defaults to :accurate.  If :fast is passed
  instead, then Polygon-to-Polygon collisions will be tested with a method
  that may return false positives in rare cases but is faster. This
  does not affect any collisions involving Rects or Circles.

  ## Examples

  iex> Collidex.Detector.collision?(
  ...>   Collidex.Geometry.Circle.make(0, 0, 1.0),
  ...>   Collidex.Geometry.Circle.make(1.0, 1.0, 1.0)
  ...> )
  {:collision, {-1.0, -1.0}}

  iex> Collidex.Detector.collision?(
  ...>   Collidex.Geometry.Rect.make(-2, -0.75, 2, -2),
  ...>   Collidex.Geometry.Rect.make(2, 0.5, 3, -0.5)
  ...> )
  false

  iex> Collidex.Detector.collision?(
  ...>   Collidex.Geometry.Rect.make(2, 0.5, 3, -0.5),
  ...>   Collidex.Geometry.Rect.make(3,-3,-3,3)
  ...> )
  {:collision, "todo_provide_vector"}

  iex> Collidex.Detector.collision?(
  ...>   Collidex.Geometry.Rect.make(-1.0, -1.0, 1.0, 1.0),
  ...>   Collidex.Geometry.Polygon.make([{0.9,0}, {2,1}, {2,-1}])
  ...> )
  {:collision, "todo_provide_vector"}

  iex> Collidex.Detector.collision?(
  ...>   Collidex.Geometry.Circle.make(0,0,1.0),
  ...>   Collidex.Geometry.Rect.make(1.1,-1,2,1)
  ...> )
  false

  """
  def collision?(shape1, shape2, method \\ :accurate)

  def collision?(c1 = %Circle{}, c2 = %Circle{}, _) do
    Circles.collision?(c1,c2)
  end
  def collision?(r1 = %Rect{}, r2 = %Rect{}, _) do
    Rects.collision?(r1,r2)
  end
  def collision(p1 = %Polygon{}, p2 = %Polygon{}, method) do
    Polygons.collision?(p1, p2, method)
  end
  def collision?(shape1, shape2, method) do
    MixedShapes.collision?(shape1, shape2, method)
  end
end
