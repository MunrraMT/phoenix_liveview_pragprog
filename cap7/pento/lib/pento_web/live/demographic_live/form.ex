defmodule PentoWeb.DemographicLive.Form do
  use PentoWeb, :live_component

  alias Pento.Survey
  alias Pento.Survey.Demographic
  alias Pento.Accounts.User
  alias Phoenix.LiveView.Socket

  @impl true
  def update(assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_demographic()
     |> clear_form()}
  end

  defp assign_demographic(%Socket{assigns: %{current_user: %User{} = user}} = socket) do
    assign(socket, :demographic, %Demographic{user_id: user.id})
  end

  defp assign_form(%Socket{} = socket, changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp clear_form(%Socket{assigns: %{demographic: demographic}} = socket) do
    assign_form(socket, Survey.change_demographic(demographic))
  end
end
