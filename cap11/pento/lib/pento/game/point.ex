defmodule Pento.Game.Point do
  def new(x, y) when is_integer(x) and is_integer(y) do
    {x, y}
  end
end
