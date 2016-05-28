# NamedArgs

Inspired by [Named Arguments with Elixir](https://blog.praveenperera.com/named-arugments-with-default-values-in-elixir/)

Allows you to use named arguments similar to Ruby's named arguments. For example, in Ruby

```ruby
def introduction(name: 'Sarah', birthday: "1985-12-30")  
  puts "Hi my name is #{name} and I was born on #{birthday}"
end
```

However in Elixir, using a default argument ends up dropping the other values.

```elixir
defmodule Talk do  
  def introduction(opts \\ [name: "Sarah", birthday: "1985-12-30"]) do
    IO.puts "Hi my name is #{opts[:name]} and I was born on #{opts[:birthday]}"
  end
end
# Drops the birthday
Talk.introduction(name: "Joe") # => Hi my name is Joe and I was born on
# Drops the name
Talk.introduction(birthday: "1985-12-30") # => Hi my name is  and I was born on 1985-12-30
```

With `NamedArgs` you can instead do the following:

```elixir
defmodule Talk do
  use NamedArgs
  def introduction(opts \\ [name: "Sarah", birthday: "1985-12-30"]) do
    IO.puts "Hi my name is #{opts[:name]} and I was born on #{opts[:birthday]}"
  end
end
# No params!
Talk.introduction # => Hi my name is Sarah and my birthday is 1985-12-30
# Keeps the birthday
Talk.introduction(name: "Joe") # => Hi my name is Joe and I was born on 1985-12-30
# Keeps the name
Talk.introduction(birthday: "1986-01-01") # => Hi my name is Sarah and I was born on 1986-01-01
# Order does not matter!
Talk.introduction(birthday: "1986-01-01", name: "Joe") # => Hi my name is Joe and I was born on 1986-01-01
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add named_args to your list of dependencies in `mix.exs`:

        def deps do
          [{:named_args, "~> 0.0.1"}]
        end

  2. Ensure named_args is started before your application:

        def application do
          [applications: [:named_args]]
        end

## But it doesn't create a variable with the same name?

Yup, I'm still not sure if thats a desired feature or not. Because it would implicitly create a variable that you may or may not decide to use, it goes against a lot of the philosophies that Elixir follows in regard to explicit coding. And the compiler would warn you about it (and it couldn't be fixed either).

If possible to remove the compiler warning this feature may become more attractive. Please let me know if you have ideas about this!
