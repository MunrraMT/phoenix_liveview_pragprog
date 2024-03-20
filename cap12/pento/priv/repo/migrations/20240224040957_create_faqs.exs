defmodule Pento.Repo.Migrations.CreateFaqs do
  use Ecto.Migration

  def change do
    create table(:faqs) do
      add :question, :string
      add :answer, :string
      add :views, :integer

      timestamps(type: :utc_datetime)
    end

    create unique_index(:faqs, [:question])
  end
end
