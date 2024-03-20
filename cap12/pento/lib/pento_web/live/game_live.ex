defmodule PentoWeb.GameLive do
  use PentoWeb, :live_view

  import PentoWeb.GameLive.Component

  def mount(_params, _session, socket), do: {:ok, socket}

  def render(assigns) do
    ~H"""
    <section class="container">
      <h1 class="font-bold text-3xl">Welcome to Pento!</h1>
      <.palette shape_names={[:i, :l, :y, :n, :p, :w, :u, :v, :s, :f, :x, :t]} />
    </section>
    """
  end
end
