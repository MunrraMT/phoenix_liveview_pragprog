alias Pento.Accounts

for i <- 1..43 do
  Accounts.register_user(%{
    email: "user_#{i}@test.com",
    password: "user_password_#{i}"
  })
end
