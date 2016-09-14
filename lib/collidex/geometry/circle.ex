defmodule Collidex.Geometry.Circle do
  @use Collidex.Geometry.Shape

  @moduledoc """
  Struct to represent perfect circles.
  """
  defstruct center: { 0.0, 0.0},
            radius: 0.0

  @doc """
  Make a circle.  All numbers are coerced to floats.  Accepts any of:
    • A tuple of three values: center x, center y, radius.
    * Three arguments: center x, center y, radius

  ## Examples

  ```
  iex> Collidex.Geometry.Circle.make({5,5,0.75})
  %Collidex.Geometry.Circle{center: { 5.0, 5.0}, radius: 0.75}

  iex> Collidex.Geometry.Circle.make(2,1,0.5)
  %Collidex.Geometry.Circle{center: {2.0, 1.0}, radius: 0.500}
  
  ```
  """
  def make({ x, y, r }) when is_number(x) and is_number(y) and is_number(r)
  do
    %__MODULE__{  center: Collidex.Utils.coerce_floats({x, y}),
                  radius: Collidex.Utils.coerce_floats(r)
                 }
  end
  def make(x, y, r), do: make {x,y,r}

  @doc """
  Return the center of the circle as an {x,y} 2-tuple
  """
  def center(circle) do
    circle.center
  end
end
