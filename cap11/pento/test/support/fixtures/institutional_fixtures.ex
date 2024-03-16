defmodule Pento.InstitutionalFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Pento.Institutional` context.
  """

  @doc """
  Generate a unique faq question.
  """
  def unique_faq_question, do: "some question#{System.unique_integer([:positive])}"

  @doc """
  Generate a faq.
  """
  def faq_fixture(attrs \\ %{}) do
    {:ok, faq} =
      attrs
      |> Enum.into(%{
        answer: "some answer",
        question: unique_faq_question(),
        views: 42
      })
      |> Pento.Institutional.create_faq()

    faq
  end
end
