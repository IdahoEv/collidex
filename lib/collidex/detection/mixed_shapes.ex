defmodule Collidex.Detection.MixedShapes do
  @moduledoc """
  Handles detection of collisions between disparate shapes. (i.e. Rects
  and Circles, Rects and Polygons, Polygons and Circles)
  """

  alias Collidex.Geometry.Rect
  alias Collidex.Geometry.Circle
  alias Collidex.Geometry.Polygon

  alias Collidex.Detection.Polygons

  @doc """
  Detect collisions between Rects and Polygons by promoting
  Rects to polygons.

  TODO: Test if a special case treatment of rects-to-polygons
  without promoting the rects has sufficiently better performance
  to justify it.
  """
  def collision?(rect = %Rect{}, poly = %Polygon{}) do
    Polygons.collision?(Polygon.make(rect), poly)
  end
  def collision?(poly = %Polygon{}, rect = %Rect{}) do
    Polygons.collision?(poly, Polygon.make(rect))
  end


end
