defmodule NamedArgsTest do
  use ExUnit.Case
  doctest NamedArgs

  defmodule Test do
    use NamedArgs
    def test(opts \\ [key: :value, another: :value]) do
      opts
    end
  end

  test "no args" do
    assert Test.test == [key: :value, another: :value]
  end

  test "one arg" do
    assert Test.test(key: :changed) == [another: :value, key: :changed]
  end

  test "other arg" do
    assert Test.test(another: :changed) == [key: :value, another: :changed]
  end

  test "both args" do
    assert Test.test(key: :changed, another: :changed) == [key: :changed, another: :changed]
    assert Test.test(another: :changed, key: :changed) == [another: :changed, key: :changed]
  end

  defmodule Test2 do
    use NamedArgs
    def test(:value, opts \\ [key: :value, another: :value]) do
      opts
    end
  end

  test "with other params - no args" do
    assert Test2.test(:value)  == [key: :value, another: :value]
  end

  test "with other params - one arg" do
    assert Test2.test(:value, key: :changed) == [another: :value, key: :changed]
  end

  test "with other params - other arg" do
    assert Test2.test(:value, another: :changed) == [key: :value, another: :changed]
  end

  test "with other params - both args" do
    assert Test2.test(:value, key: :changed, another: :changed) == [key: :changed, another: :changed]
    assert Test2.test(:value, another: :changed, key: :changed) == [another: :changed, key: :changed]
  end

end
