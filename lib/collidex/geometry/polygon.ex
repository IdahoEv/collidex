defmodule Collidex.Geometry.Polygon do
  @moduledoc """
  An n-sided polygon.
  """
  defstruct vertices: []

  @doc """
  Make a polygon from a list of vertices (2-tuples).

  ## Example
  iex> Collidex.Geometry.Polygon.make([{1,2}, {2, 2}, {2,0}, {1,0} ])
  %Collidex.Geometry.Polygon{vertices: [{1,2}, {2, 2}, {2,0}, {1,0} ]}
  """
  def make(vertices) when is_list(vertices) do
    %__MODULE__{ vertices: vertices }
  end

end