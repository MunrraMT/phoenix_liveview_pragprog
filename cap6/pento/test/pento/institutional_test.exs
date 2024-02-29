defmodule Pento.InstitutionalTest do
  use Pento.DataCase

  alias Pento.Institutional

  describe "faqs" do
    alias Pento.Institutional.FAQ

    import Pento.InstitutionalFixtures

    @invalid_attrs %{answer: nil, question: nil, views: nil}

    test "list_faqs/0 returns all faqs" do
      faq = faq_fixture()
      assert Institutional.list_faqs() == [faq]
    end

    test "get_faq!/1 returns the faq with given id" do
      faq = faq_fixture()
      assert Institutional.get_faq!(faq.id) == faq
    end

    test "create_faq/1 with valid data creates a faq" do
      valid_attrs = %{answer: "some answer", question: "some question", views: 42}

      assert {:ok, %FAQ{} = faq} = Institutional.create_faq(valid_attrs)
      assert faq.answer == "some answer"
      assert faq.question == "some question"
      assert faq.views == 42
    end

    test "create_faq/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Institutional.create_faq(@invalid_attrs)
    end

    test "update_faq/2 with valid data updates the faq" do
      faq = faq_fixture()
      update_attrs = %{answer: "some updated answer", question: "some updated question", views: 43}

      assert {:ok, %FAQ{} = faq} = Institutional.update_faq(faq, update_attrs)
      assert faq.answer == "some updated answer"
      assert faq.question == "some updated question"
      assert faq.views == 43
    end

    test "update_faq/2 with invalid data returns error changeset" do
      faq = faq_fixture()
      assert {:error, %Ecto.Changeset{}} = Institutional.update_faq(faq, @invalid_attrs)
      assert faq == Institutional.get_faq!(faq.id)
    end

    test "delete_faq/1 deletes the faq" do
      faq = faq_fixture()
      assert {:ok, %FAQ{}} = Institutional.delete_faq(faq)
      assert_raise Ecto.NoResultsError, fn -> Institutional.get_faq!(faq.id) end
    end

    test "change_faq/1 returns a faq changeset" do
      faq = faq_fixture()
      assert %Ecto.Changeset{} = Institutional.change_faq(faq)
    end
  end
end
