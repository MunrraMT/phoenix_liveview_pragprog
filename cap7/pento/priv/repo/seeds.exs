# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Pento.Repo.insert!(%Pento.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Pento.Catalog
alias Pento.Accounts
alias Pento.Survey

products = [
  %{
    name: "Chess",
    description: "The classic strategy game",
    sku: 5_678_910,
    unit_price: 10.00
  },
  %{
    name: "Tic-Tac-Toe",
    description: "The game of Xs and Os",
    sku: 11_121_314,
    unit_price: 3.00
  },
  %{
    name: "Table Tennis",
    description: "Bat the ball back and forth. Don't miss!",
    sku: 15_222_324,
    unit_price: 12.00
  }
]

users = [
  %{email: "teste_a@email.com", password: "123456789012"},
  %{email: "teste_b@email.com", password: "123456789012"},
  %{email: "teste_c@email.com", password: "123456789012"}
]

Enum.each(products, fn product ->
  Catalog.create_product(product)
end)

Enum.each(users, fn user ->
  Accounts.register_user(user)
end)

demographics = [
  %{
    gender: "male",
    year_of_birth: "2000",
    user_id: Accounts.get_user_by_email(hd(users).email).id
  },
  %{
    gender: "female",
    year_of_birth: "2002",
    user_id: Accounts.get_user_by_email(Enum.at(users, 1).email).id
  }
]

ratings = [
  %{
    stars: 3,
    product_id: Catalog.get_product_by_sku(hd(products).sku).id,
    user_id: Accounts.get_user_by_email(hd(users).email).id
  }
]

Enum.each(demographics, fn demographic ->
  Survey.create_demographic(demographic)
end)

Enum.each(ratings, fn rating ->
  Survey.create_rating(rating)
end)
