defmodule PentoWeb.Admin.SurveyResultsLive do
  use PentoWeb, :live_component

  alias Pento.Catalog

  def update(assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_products_with_average_ratings()
     |> assign_dataset()}
  end

  def assign_dataset(%{products_with_average_ratings: products_with_average_ratings} = socket) do
    socket
    |> assign(
      :dataset,
      make_bar_chart_dataset(products_with_average_ratings)
    )
  end

  defp assign_products_with_average_ratings(socket) do
    socket
    |> assign(:products_with_average_ratings, Catalog.products_with_average_ratings())
  end

  defp make_bar_chart_dataset(data) do
    data
    |> Contex.Dataset.new()
  end
end
