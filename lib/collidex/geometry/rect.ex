defmodule Collidex.Geometry.Rect do
  @moduledoc """
  Struct to represent grid-aligned rectangles as a pair of points (A and B).
  """
  defstruct a: %{x: 0.0, y: 0.0},
            b: %{x: 0.0, y: 0.0}

  @doc """
  Make a rect from a tuple of four arguments: x1, y1, x2, y2

  ## Example
  iex> Collidex.Geometry.Rect.make({ 1, 2, 50.1, 51.1 })
  %Collidex.Geometry.Rect{a: %{x: 1, y: 2}, b: %{x: 50.1, y: 51.1}}
  """
  def make({ x1, y1, x2, y2 })
    when is_number(x1)
      and is_number(y1)
      and is_number(x2)
      and is_number(y2)
  do
    %__MODULE__{  a: %{ x: x1, y: y1},
                  b: %{ x: x2, y: y2},
                }
  end


  @doc """
  Make a rect from four arguments: x1, y1, x2, y2

  ## Example
  iex> Collidex.Geometry.Rect.make( 1, 2, 50.1, 51.1 )
  %Collidex.Geometry.Rect{a: %{x: 1, y: 2}, b: %{x: 50.1, y: 51.1}}
  """
  def make( x1, y1, x2, y2 )
    when is_number(x1)
      and is_number(y1)
      and is_number(x2)
      and is_number(y2)
  do
    %__MODULE__{  a: %{ x: x1, y: y1},
                  b: %{ x: x2, y: y2},
                }
  end


end