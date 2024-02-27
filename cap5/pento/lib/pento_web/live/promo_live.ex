defmodule PentoWeb.PromoLive do
  use PentoWeb, :live_view

  alias Pento.Promo
  alias Pento.Promo.Recipient

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign_recipient()
     |> clear_form()}
  end

  def assign_recipient(socket) do
    socket
    |> assign(:recipient, %Recipient{})
  end

  def clear_form(socket) do
    form =
      socket.assigns.recipient
      |> Promo.change_recipient()
      |> to_form()

    assign(socket, :form, form)
  end

  def assign_form(socket, changeset) do
    assign(socket, :form, to_form(changeset))
  end

  @impl true
  def handle_event(
        "validate",
        %{"recipient" => recipient_params},
        %{assigns: %{recipient: recipient}} = socket
      ) do
    {:noreply,
     assign_form(
       socket,
       changeset_validated(recipient, recipient_params)
     )}
  end

  @impl true
  def handle_event(
        "save",
        %{"recipient" => recipient_params},
        %{assigns: %{recipient: recipient}} = socket
      ) do
    changeset =
      changeset_validated(recipient, recipient_params)

    case changeset.valid? do
      true ->
        {:noreply, push_redirect(socket, to: ~p"/guess")}

      false ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp changeset_validated(recipient, recipient_params) do
    recipient
    |> Promo.change_recipient(recipient_params)
    |> Map.put(:action, :validate)
  end
end
