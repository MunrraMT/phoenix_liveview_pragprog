alias Pento.Repo
alias Pento.Accounts.User
alias Pento.Catalog.Product
alias Pento.Survey

require Ecto.Query
user_ids = Repo.all(Ecto.Query.from(u in User, select: u.id))
product_ids = Repo.all(Ecto.Query.from(p in Product, select: p.id))
genders = ["female", "male", "other", "prefer not to say"]
years = 1960..2017
stars = 1..5

for u_id <- user_ids do
  Survey.create_demographic(%{
    user_id: u_id,
    gender: Enum.random(genders),
    year_of_birth: Enum.random(years)
  })
end

for u_id <- user_ids, p_id <- product_ids do
  Survey.create_rating(%{
    user_id: u_id,
    product_id: p_id,
    stars: Enum.random(stars)
  })
end
