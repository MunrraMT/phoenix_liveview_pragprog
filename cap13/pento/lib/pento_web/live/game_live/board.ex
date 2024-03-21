defmodule PentoWeb.GameLive.Board do
  use PentoWeb, :live_component

  alias Pento.Game
  alias Pento.Game.Board

  import PentoWeb.GameLive.Colors
  import PentoWeb.GameLive.Component

  @impl true
  def update(%{puzzle: puzzle, id: id} = _assigns, socket) do
    {:ok,
     socket
     |> assign_params(id, puzzle)
     |> assign_board()
     |> assign_shapes()}
  end

  @impl true
  def handle_event("pick", %{"name" => name}, socket) do
    {:noreply,
     socket
     |> pick(name)
     |> assign_shapes()}
  end

  @impl true
  def handle_event("key", %{"key" => key}, socket) do
    {:noreply,
     socket
     |> do_key(key)
     |> assign_shapes()}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div id={@id} phx-window-keydown="key" phx-target={@myself}>
      <.canvas view_box="0 0 200 70">
        <%= for shape <- @shapes do %>
          <.shape
            points={shape.points}
            fill={color(shape.color, Board.active?(@board, shape.name), false)}
            name={shape.name}
          />
        <% end %>
      </.canvas>
      <hr />
      <.palette
        shape_names={@board.palette}
        completed_shape_names={Enum.map(@board.completed_pentos, & &1.name)}
      />
    </div>
    """
  end

  def assign_params(socket, id, puzzle) do
    socket
    |> assign(:id, id)
    |> assign(:puzzle, puzzle)
  end

  def assign_board(%{assigns: %{puzzle: puzzle}} = socket) do
    board =
      puzzle
      |> String.to_atom()
      |> Board.new()

    socket
    |> assign(:board, board)
  end

  def assign_shapes(%{assigns: %{board: board}} = socket) do
    shapes = Board.to_shapes(board)

    socket
    |> assign(:shapes, shapes)
  end

  def do_key(socket, key) do
    case key do
      " " -> drop(socket)
      "ArrowLeft" -> move(socket, :left)
      "ArrowRight" -> move(socket, :right)
      "ArrowUp" -> move(socket, :up)
      "ArrowDown" -> move(socket, :down)
      "Shift" -> move(socket, :rotate)
      "Enter" -> move(socket, :flip)
      "Space" -> drop(socket)
      _ -> socket
    end
  end

  def move(socket, move) do
    case Game.maybe_move(socket.assigns.board, move) do
      {:error, message} ->
        put_flash(socket, :info, message)

      {:ok, board} ->
        socket
        |> assign(:board, board)
        |> assign_shapes()
    end
  end

  def drop(socket) do
    case Game.maybe_drop(socket.assigns.board) do
      {:error, message} ->
        put_flash(socket, :info, message)

      {:ok, board} ->
        socket
        |> assign(:board, board)
        |> assign_shapes()
    end
  end

  defp pick(socket, name) do
    shape_name = String.to_existing_atom(name)
    update(socket, :board, &Board.pick(&1, shape_name))
  end
end
