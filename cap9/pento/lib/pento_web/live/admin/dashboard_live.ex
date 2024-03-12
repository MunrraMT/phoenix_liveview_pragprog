defmodule PentoWeb.Admin.DashboardLive do
  alias PentoWeb.Admin.SurveyResultsLive
  use PentoWeb, :live_view

  alias PentoWeb.Endpoint

  @survey_results_topic "survey_results"

  @impl true
  def mount(_params, _session, socket) do
    if(connected?(socket)) do
      Endpoint.subscribe(@survey_results_topic)
    end

    {:ok,
     socket
     |> assign(:survey_results_component_id, "survey_results")}
  end

  @impl true
  def handle_info(%{event: "rating_created"}, socket) do
    send_update(
      SurveyResultsLive,
      id: socket.assigns.survey_results_component_id
    )

    {:noreply, socket}
  end
end