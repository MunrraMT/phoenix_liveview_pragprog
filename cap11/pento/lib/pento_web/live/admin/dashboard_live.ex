defmodule PentoWeb.Admin.DashboardLive do
  use PentoWeb, :live_view

  alias PentoWeb.Endpoint
  alias PentoWeb.Admin.UserActivityLive
  alias PentoWeb.Admin.SurveyResultsLive

  @survey_results_topic "survey_results"
  @user_activity_topic "user_activity"

  @impl true
  def mount(_params, _session, socket) do
    if(connected?(socket)) do
      Endpoint.subscribe(@survey_results_topic)
      Endpoint.subscribe(@user_activity_topic)
    end

    {:ok,
     socket
     |> assign(:survey_results_component_id, "survey_results")
     |> assign(:user_activity_component_id, "user_activity")}
  end

  @impl true
  def handle_info(%{event: "rating_created"}, socket) do
    send_update(
      SurveyResultsLive,
      id: socket.assigns.survey_results_component_id
    )

    {:noreply, socket}
  end

  def handle_info(%{event: "presence_diff"}, socket) do
    send_update(
      UserActivityLive,
      id: socket.assigns.user_activity_component_id
    )

    {:noreply, socket}
  end
end