defmodule PentoWeb.Admin.SurveyResultsLive do
  use PentoWeb, :live_component
  use PentoWeb, :chart_live

  alias Pento.Catalog

  @impl true
  def update(assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_age_group_filter()
     |> assign_gender_filter()
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
    |> assign(
      :chart_svg,
      render_bar_chart(
        chart,
        title(),
        subtitle(),
        x_axis(),
        y_axis()
      )
    )
  end

  def assign_age_group_filter(socket, age_group_filter) do
    socket
    |> assign(:age_group_filter, age_group_filter)
  end

  def assign_age_group_filter(%{assigns: %{age_group_filter: age_group_filter}} = socket) do
    socket
    |> assign(:age_group_filter, age_group_filter)
  end

  def assign_age_group_filter(socket) do
    socket
    |> assign(:age_group_filter, "all")
  end

  @impl true
  def handle_event(
        "age_group_filter",
        %{
          "age_group_filter" => age_group_filter
        },
        socket
      ) do
    {:noreply,
     socket
     |> assign_age_group_filter(age_group_filter)
     |> assign_products_with_average_ratings()
     |> assign_dataset()
     |> assign_chart()
     |> assign_chart_svg()}
  end

  def assign_gender_filter(socket, gender_filter) do
    socket
    |> assign(:gender_filter, gender_filter)
  end

  def assign_gender_filter(%{assigns: %{gender_filter: gender_filter}} = socket) do
    socket
    |> assign(:gender_filter, gender_filter)
  end

  def assign_gender_filter(socket) do
    socket
    |> assign(:gender_filter, "all")
  end

  @impl true
  def handle_event(
        "gender_filter",
        %{
          "gender_filter" => gender_filter
        },
        socket
      ) do
    {:noreply,
     socket
     |> assign_gender_filter(gender_filter)
     |> assign_products_with_average_ratings()
     |> assign_dataset()
     |> assign_chart()
     |> assign_chart_svg()}
  end

  def assign_products_with_average_ratings(
        %{
          assigns: %{
            age_group_filter: age_group_filter,
            gender_filter: gender_filter
          }
        } = socket
      ) do
    socket
    |> assign(
      :products_with_average_ratings,
      get_products_with_average_ratings(%{
        age_group_filter: age_group_filter,
        gender_filter: gender_filter
      })
    )
  end

  defp assign_chart(%{assigns: %{dataset: dataset}} = socket) do
    socket
    |> assign(:chart, make_bar_chart(dataset))
  end

  defp title(), do: "Product Ratings"
  defp subtitle(), do: "average star ratings per product"
  defp x_axis(), do: "products"
  defp y_axis(), do: "stars"

  defp get_products_with_average_ratings(filter) do
    case Catalog.products_with_average_ratings(filter) do
      [] ->
        Catalog.products_with_zero_ratings()

      products ->
        products
    end
  end
end
