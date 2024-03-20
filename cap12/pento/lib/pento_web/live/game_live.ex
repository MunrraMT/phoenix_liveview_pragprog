defmodule PentoWeb.GameLive do
  use PentoWeb, :live_view

  import PentoWeb.GameLive.Component

  def mount(_params, _session, socket), do: {:ok, socket}

  def render(assigns) do
    ~H"""
    <section class="container">
      <h1 class="font-bold text-3xl">Welcome to Pento!</h1>
      <.canvas view_box="0 0 220 70">
        <.shape points={[{3, 2}, {4, 3}, {3, 3}, {4, 2}, {3, 4}]} fill="orange" name="p" />
      </.canvas>
    </section>
    """
  end
end
