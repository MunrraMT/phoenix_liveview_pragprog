defmodule PentoWeb.DemographicLive.Show do
  use Phoenix.Component
  use PhoenixHTMLHelpers

  import Phoenix.HTML
  import Phoenix.HTML.Form

  alias PentoWeb.RatingLive
  alias PentoWeb.DemographicLive
  alias Pento.Survey.Demographic
  alias PentoWeb.CoreComponents

  attr :demographic, Demographic, required: true

  def details(assigns) do
    ~H"""
    <div>
      <h2 class="font-medium text-2xl">
        Demographic <%= raw("&#x2713;") %>
      </h2>

      <CoreComponents.table rows={[@demographic]} id={to_string(@demographic.id)}>
        <:col :let={demographic} label="Gender">
          <%= demographic.gender %>
        </:col>
        <:col :let={demographic} label="Year of birth">
          <%= demographic.year_of_birth %>
        </:col>
      </CoreComponents.table>
    </div>
    """
  end
end
