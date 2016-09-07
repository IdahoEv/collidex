defmodule Collidex.Geometry.Circle do
  @moduledoc """
  Struct to represent perfect circles.
  """
  defstruct center: %{x: 0.0, y: 0.0},
            radius: 0.0

  @doc """
  Make a circle from a tuple of three arguments: center x, center y, radius.

  ## Example

  iex> Collidex.Geometry.Circle.make({5,5,0.75})
  %Collidex.Geometry.Circle{center: %{x: 5, y: 5}, radius: 0.75}
  """
  def make({ x, y, r }) when is_number(x) and is_number(y) and is_number(r)
  do
    %__MODULE__{  center: %{ x: x, y: y},
                  radius: r
                 }
  end

  @doc """
  Make a circle from a tuple of three arguments: center x, center y, radius.

  ## Example

  iex> Collidex.Geometry.Circle.make(2,1,0.5)
  %Collidex.Geometry.Circle{center: %{x: 2, y: 1}, radius: 0.500}
  """
  def make(x, y, r), do: make {x,y,r}

end