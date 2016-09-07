defmodule Collidex.Geometry.Circle do
  @use Collidex.Geometry.Shape

  @moduledoc """
  Struct to represent perfect circles.
  """
  defstruct center: { 0.0, 0.0},
            radius: 0.0

  @doc """
  Make a circle from a tuple of three arguments: center x, center y, radius.

  ## Example

  iex> Collidex.Geometry.Circle.make({5,5,0.75})
  %Collidex.Geometry.Circle{center: { 5, 5}, radius: 0.75}
  """
  def make({ x, y, r }) when is_number(x) and is_number(y) and is_number(r)
  do
    %__MODULE__{  center: {x, y},
                  radius: r
                 }
  end

  @doc """
  Make a circle from a tuple of three arguments: center x, center y, radius.

  ## Example

  iex> Collidex.Geometry.Circle.make(2,1,0.5)
  %Collidex.Geometry.Circle{center: {2, 1}, radius: 0.500}
  """
  def make(x, y, r), do: make {x,y,r}


  @doc """
  Return the center of the circle as an {x,y} 2-tuple
  """
  def center(circle) do
    circle.center
  end
end