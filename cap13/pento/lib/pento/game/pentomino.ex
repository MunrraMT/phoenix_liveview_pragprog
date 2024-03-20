defmodule Pento.Game.Pentomino do
  @names [:i, :l, :y, :n, :p, :w, :u, :v, :s, :f, :x, :t]
  @default_location {8, 8}

  defstruct name: :i,
            rotation: 0,
            reflected: false,
            location: @default_location

  alias Pento.Game.Shape
  alias Pento.Game.Point

  def new(fields \\ []), do: __struct__(fields)

  def rotate(%__MODULE__{rotation: degrees} = p) do
    %{p | rotation: rem(degrees + 90, 360)}
  end

  def flip(%__MODULE__{reflected: reflection} = p) do
    %{p | reflected: not reflection}
  end

  def up(%__MODULE__{} = p) do
    %{p | location: Point.move(p.location, {0, -1})}
  end

  def down(%__MODULE__{} = p) do
    %{p | location: Point.move(p.location, {0, 1})}
  end

  def left(%__MODULE__{} = p) do
    %{p | location: Point.move(p.location, {-1, 0})}
  end

  def right(%__MODULE__{} = p) do
    %{p | location: Point.move(p.location, {1, 0})}
  end

  def to_shape(%__MODULE__{} = pento) do
    Shape.new(pento.name, pento.rotation, pento.reflected, pento.location)
  end

  def overlapping?(pento1, pento2) do
    {p1, p2} = {to_shape(pento1).points, to_shape(pento2).points}

    Enum.count(p1 -- p2) != 5
  end
end
