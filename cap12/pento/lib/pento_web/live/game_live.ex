defmodule PentoWeb.GameLive do
  use PentoWeb, :live_view

  alias Pento.GameLive.Board

  import PentoWeb.GameLive.Component

  def mount(%{"puzzle" => puzzle} = _params, _session, socket) do
    {:ok,
     socket
     |> assign(:puzzle, puzzle)}
  end

  def render(assigns) do
    ~H"""
    <section class="container">
      <h1 class="font-bold text-3xl">Welcome to Pento!</h1>
      <.live_component module={Board} puzzle={@puzzle} id="game" />
    </section>
    """
  end
end
