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
    def test(:value, options \\ [key: :value, another: :value]) do
      options
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

  defmodule Test3 do
    use NamedArgs
    def test(options \\ %{key: :value, another: :value}) do
      options
    end
  end

  test "map - no args" do
    assert Test3.test()  == %{key: :value, another: :value}
  end
  @tag :focus
  test "map - one arg" do
    assert Test3.test(%{key: :changed}) == %{another: :value, key: :changed}
  end

  test "map - other arg" do
    assert Test3.test(%{another: :changed}) == %{key: :value, another: :changed}
  end

  test "map - both args" do
    assert Test3.test(%{key: :changed, another: :changed}) == %{key: :changed, another: :changed}
    assert Test3.test(%{another: :changed, key: :changed}) == %{another: :changed, key: :changed}
  end

end
