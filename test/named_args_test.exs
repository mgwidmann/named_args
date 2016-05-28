defmodule NamedArgsTest do
  use ExUnit.Case
  doctest NamedArgs

  defmodule KeywordArg do
    use NamedArgs
    def test(opts \\ [key: :value, another: :value]) do
      opts
    end
  end

  test "no args" do
    assert KeywordArg.test == [key: :value, another: :value]
  end

  test "one arg" do
    assert KeywordArg.test(key: :changed) == [another: :value, key: :changed]
  end

  test "other arg" do
    assert KeywordArg.test(another: :changed) == [key: :value, another: :changed]
  end

  test "both args" do
    assert KeywordArg.test(key: :changed, another: :changed) == [key: :changed, another: :changed]
    assert KeywordArg.test(another: :changed, key: :changed) == [another: :changed, key: :changed]
  end

  defmodule KeywordWithOther do
    use NamedArgs
    def test(:value, options \\ [key: :value, another: :value]) do
      options
    end
  end

  test "with other params - no args" do
    assert KeywordWithOther.test(:value)  == [key: :value, another: :value]
  end

  test "with other params - one arg" do
    assert KeywordWithOther.test(:value, key: :changed) == [another: :value, key: :changed]
  end

  test "with other params - other arg" do
    assert KeywordWithOther.test(:value, another: :changed) == [key: :value, another: :changed]
  end

  test "with other params - both args" do
    assert KeywordWithOther.test(:value, key: :changed, another: :changed) == [key: :changed, another: :changed]
    assert KeywordWithOther.test(:value, another: :changed, key: :changed) == [another: :changed, key: :changed]
  end

  defmodule MapArg do
    use NamedArgs
    def test(options \\ %{key: :value, another: :value}) do
      options
    end
  end

  defmodule SingleMapArg do
    use NamedArgs
    def test(options \\ %{key: :value}) do
      options
    end
  end

  test "single map - no args" do
    assert SingleMapArg.test()  == %{key: :value}
  end

  test "single map - one arg" do
    assert SingleMapArg.test(%{key: :changed}) == %{key: :changed}
  end

  defmodule DefaultArgs do
    use NamedArgs
    def test(data, another_data \\ 123, more_data \\ :foo) do
      {data, another_data, more_data}
    end
  end

  test "ignores functions with other default params" do
    assert DefaultArgs.test("data") == {"data", 123, :foo}
  end

  test "allows using default params as usual" do
    assert DefaultArgs.test("data", 456, :bar) == {"data", 456, :bar}
  end

end
