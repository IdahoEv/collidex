defmodule Collidex.Detection.Circles do
  @moduledoc """
  Detect collisions (or not) between pairs of circles
  """

  @doc """
  Check for a collision between two circles c1 and c2. Return
  value is truthy if the two circles overlap on the plane.

  ## Examples

  ```
  iex> Collidex.Detection.Circles.collision?(
  ...>   Collidex.Geometry.Circle.make(0.0, 0.0, 1.0),
  ...>   Collidex.Geometry.Circle.make(1.0, 1.0, 1.0)
  ...> )
  { :collision, {-1.0, -1.0} }

  iex> Collidex.Detection.Circles.collision?(
  ...>   Collidex.Geometry.Circle.make(0.0, 0.0, 1.0),
  ...>   Collidex.Geometry.Circle.make(3.0, 3.0, 1.0)
  ...> )
  false

  ```
  """
  def collision?(c1, c2) do
    limit = c1.radius + c2.radius
    {c1x, c1y} = c1.center
    {c2x, c2y} = c2.center
    dx = c1x - c2x
    dy = c1y - c2y
    distance = :math.sqrt( dx * dx + dy * dy )
    cond do
      distance <= limit ->
        { :collision, {dx, dy} }
      true ->
        false
    end
  end
end
#
