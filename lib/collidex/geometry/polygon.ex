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

  @doc """
  computes the centroid of a polygon by accumulating an average of the vertices.
  """
  def center(polygon) do
    { result_x, result_y, _ } = Enum.reduce(
      polygon.vertices,
      {0.0, 0.0, 1},
      fn {x, y}, { acc_x, acc_y, count} ->
        IO.puts "adding value {#{x}, #{y}} to accumulator {#{acc_x}, #{acc_y}, #{count}}"
        { acc_x - (acc_x / count) + (x / count),
          acc_y - (acc_y / count) + (y / count),
          count + 1
        }
      end
    )
    { result_x, result_y }
  end
end