defmodule PentoWeb.Admin.SurveyResultsLive do
  use PentoWeb, :live_component

  alias Pento.Catalog

  def update(assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_products_with_average_ratings()
     |> assign_dataset()
     |> assign_chart()
     |> assign_chart_svg()}
  end

  def assign_dataset(
        %{
          assigns: %{
            products_with_average_ratings: products_with_average_ratings
          }
        } = socket
      ) do
    socket
    |> assign(
      :dataset,
      make_bar_chart_dataset(products_with_average_ratings)
    )
  end

  def assign_chart_svg(%{assigns: %{chart: chart}} = socket) do
    socket
    |> assign(:chart_svg, render_bar_chart(chart))
  end

  defp assign_products_with_average_ratings(socket) do
    socket
    # |> assign(
    #   :products_with_average_ratings,
    #   Catalog.products_with_average_ratings()
    # )
  end

  defp make_bar_chart_dataset(data) do
    data
    |> Contex.Dataset.new()
  end

  defp assign_chart(%{assigns: %{dataset: dataset}} = socket) do
    socket
    |> assign(:chart, make_bar_chart(dataset))
  end

  defp make_bar_chart(dataset) do
    dataset
    |> Contex.BarChart.new()
  end

  defp render_bar_chart(chart) do
    Contex.Plot.new(500, 400, chart)
    |> Contex.Plot.titles(title(), subtitle())
    |> Contex.Plot.axis_labels(x_axis(), y_axis())
    |> Contex.Plot.to_svg()
  end

  defp title(), do: "Product Ratings"
  defp subtitle(), do: "average star ratings per product"
  defp x_axis(), do: "products"
  defp y_axis(), do: "stars"
end
