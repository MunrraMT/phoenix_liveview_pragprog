defmodule PentoWeb.Admin.SurveyResultsLive do
  use PentoWeb, :live_component

  def update(assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_products_with_average_ratings()}
  end
end
