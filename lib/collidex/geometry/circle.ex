defmodule Collidex.Geometry.Circle do
  @moduledoc """
  Struct to represent perfect circles.
  """
  alias Collidex.Geometry.Vector2
  defstruct center: %Vector2{},
            radius: 0.0


  @doc """
  Make a circle from a tuple of three arguments: center x, center y, radius.

  ## Examples
  iex> Collidex.Geometry.Circle.make({5,5,0.75})
  %Collidex.Geometry.Circle{center: %Collidex.Geometry.Vector2{x: 5, y: 5},
  radius: 0.75}
  """
  def make({ x, y, r }) when is_number(x) and is_number(y) and is_number(r)
  do
    %__MODULE__{  center: %Vector2{ x: x, y: y},
                  radius: r
                 }
  end

end