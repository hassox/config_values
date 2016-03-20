defmodule ConfigValuesTest do
  use ExUnit.Case
  doctest ConfigValues

  @variable "VARIABLE_NAME"
  @val "BOB"

  @variable2 "VARIABLE_NAME_TWO"
  @val2 "BETTY"

  import ConfigValues

  setup do
    System.put_env(@variable, @val)
    System.put_env(@variable2, @val2)
    {:ok, %{}}
  end

  test "a basic value" do
    assert config_value("val") == "val"
  end

  test "single interpolated value" do
    assert config_value({:system, @variable}) == @val
  end

  test "simple list" do
    assert config_value([1,2,3]) == [1,2,3]
  end

  test "simple key value" do
    assert config_value(key: [1,2,3]) == [key: [1,2,3]]
  end

  test "an interpolated keylist" do
    assert config_value(key: {:system, @variable}) == [key: @val]
  end

  test "a list of interpolated values" do
    given = [key: [system: @variable, system: @variable2]]
    expected = [key: [@val, @val2]]
    assert config_value(given) == expected
  end

  test "a map of simple values" do
    given = %{
      key: "barry",
      another: "bazza"
    }

    assert config_value(given) == given
  end

  test "a map of interpolated values" do
    given = %{
      bob: {:system, @variable},
      betty: {:system, @variable2},
    }

    expected = %{
      bob: @val,
      betty: @val2
    }

    assert config_value(given) == expected
  end

  test "a complex structure" do
    given = [
      some: "key",
      bob: {:system, @variable},
      mixed: %{
        interpolated: [system: @variable, system: @variable2],
        other: 4
      }
    ]

    expected = [
      some: "key",
      bob: @val,
      mixed: %{
        interpolated: [@val, @val2],
        other: 4
      }
    ]

    assert config_value(given) == expected
  end
end
