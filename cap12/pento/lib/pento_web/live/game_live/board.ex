defmodule PentoWeb.GameLive.Board do
  use PentoWeb, :live_component

  alias Pento.Game.Board
  alias Pento.Game.Pentomino

  import PentoWeb.GameLive.Colors
  import PentoWeb.GameLive.Component

  def update(%{puzzle: puzzle, id: id} = _assigns, socket) do
    {:ok,
     socket
     |> assign_params(id, puzzle)
     |> assign_board()
     |> assign_shapes()}
  end

  def assign_params(socket, id, puzzle) do
    socket
    |> assign(:id, id)
    |> assign(:puzzle, puzzle)
  end

  def assign_board(%{assigns: %{puzzle: puzzle}} = socket) do
    active = Pentomino.new(name: :p, location: {3, 2})

    completed = [
      Pentomino.new(name: :u, rotation: 270, location: {1, 2}),
      Pentomino.new(name: :v, rotation: 90, location: {4, 2})
    ]

    _puzzles = Board.puzzles()

    board =
      puzzle
      |> String.to_existing_atom()
      |> Board.new()
      |> Map.put(:completed_pentos, completed)
      |> Map.put(:active_pento, active)

    socket
    |> assign(:board, board)
  end

  def assign_shapes(%{assigns: %{board: board}} = socket) do
    shape = Board.to_shape(board)

    socket
    |> assign(:shapes, [shape])
  end
end
