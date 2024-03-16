defmodule Pento.Institutional.FAQ do
  use Ecto.Schema
  import Ecto.Changeset

  schema "faqs" do
    field :answer, :string
    field :question, :string
    field :views, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(faq, attrs) do
    faq
    |> cast(attrs, [:question, :answer, :views])
    |> validate_required([:question, :answer, :views])
    |> unique_constraint(:question)
  end
end
