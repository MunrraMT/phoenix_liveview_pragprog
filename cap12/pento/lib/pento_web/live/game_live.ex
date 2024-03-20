defmodule PentoWeb.GameLive do
  use PentoWeb, :live_view

  def mount(_params, _session, socket), do: {:ok, socket}

  def render(assigns) do
    ~H"""
    <section class="container">
      <h1 class="font-bold text-3xl">Welcome to Pento!</h1>
    </section>
    <svg viewBox="0 0 100 100">
      <defs><rect id="point" width="10" height="10" /></defs>
      <use xlink:href="#point" x="0" y="0" fill="blue" />
      <use xlink:href="#point" x="10" y="0" fill="green" />
      <use xlink:href="#point" x="0" y="10" fill="red" />
      <use xlink:href="#point" x="10" y="10" fill="black" />
    </svg>
    """
  end
end
