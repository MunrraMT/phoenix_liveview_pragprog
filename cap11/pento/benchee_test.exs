Mix.install([{:benchee, "~> 1.3"}])

defmodule RandomUtils do
  def random_integer_enum(min, max) do
    Enum.random(min..max)
  end

  def random_integer_float(min, max) do
    round(:rand.uniform() * (max - min + 1)) + min
  end
end

Benchee.run(%{
  "random_integer_enum" => fn -> RandomUtils.random_integer_enum(1, 100) end,
  "random_integer_float" => fn -> RandomUtils.random_integer_float(1, 100) end
})
