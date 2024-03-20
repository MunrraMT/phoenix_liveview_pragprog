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

Code.require_file("./seeds/user_seeds.exs", __DIR__)
Code.require_file("./seeds/product_seeds.exs", __DIR__)
Code.require_file("./seeds/survey_seeds.exs", __DIR__)
