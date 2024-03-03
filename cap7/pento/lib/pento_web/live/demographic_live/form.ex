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

  @impl true
  def handle_event("save", %{"demographic" => demographic_params}, %Socket{} = socket) do
    params = params_with_user_id(demographic_params, socket)

    {:noreply,
     socket
     |> save_demographic(params)}
  end

  defp assign_demographic(%Socket{assigns: %{current_user: %User{} = user}} = socket) do
    assign(socket, :demographic, %Demographic{user_id: user.id})
  end

  defp assign_form(%Socket{} = socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp clear_form(%Socket{assigns: %{demographic: demographic}} = socket) do
    assign_form(socket, Survey.change_demographic(demographic))
  end

  defp params_with_user_id(params, %Socket{assigns: %{current_user: %User{} = user}} = _socket) do
    params
    |> Map.put("user_id", user.id)
  end

  defp save_demographic(%Socket{} = socket, demographic_params) do
    case Survey.create_demographic(demographic_params) do
      {:ok, demographic} ->
        send(self(), {:created_demographic, demographic})
        socket

      {:error, %Ecto.Changeset{} = changeset} ->
        assign_form(socket, changeset)
    end
  end
end
