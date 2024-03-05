defmodule PentoWeb.SurveyLive do
  alias Pento.Catalog
  use PentoWeb, :live_view

  alias __MODULE__.Component
  alias Pento.Survey
  alias PentoWeb.DemographicLive
  alias PentoWeb.RatingLive
  alias PentoWeb.RatingLive.Show

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign_demographic()
     |> assign_products()}
  end

  def assign_demographic(
        %{
          assigns: %{current_user: current_user}
        } = socket
      ) do
    assign(
      socket,
      :demographic,
      Survey.get_demographic_by_user(current_user)
    )
  end

  def assign_products(
        %{
          assigns: %{current_user: current_user}
        } = socket
      ) do
    assign(
      socket,
      :products,
      list_products(current_user)
    )
  end

  @impl true
  def handle_info({:created_demographic, demographic}, socket) do
    {:noreply,
     socket
     |> handle_demographic_created(demographic)}
  end

  def handle_demographic_created(socket, demographic) do
    socket
    |> put_flash(:info, "Demographic created successfully")
    |> assign(:demographic, demographic)
  end

  defp list_products(user) do
    Catalog.list_products_with_user_rating(user)
  end
end
