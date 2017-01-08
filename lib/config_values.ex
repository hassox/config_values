defmodule ConfigValues do
  defmodule MissingEnvironmentVar, do: defexception message: ""

  @doc ~S"""
  Parses the given value replacing system variables

  ## Examples

      iex> System.put_env("VARIABLE_VALUE", "BOB")
      :ok
      iex> ConfigValues.config_value({:system, "VARIABLE_VALUE"})
      "BOB"
      iex> ConfigValues.config_value(bob: {:system, "VARIABLE_VALUE"}, harry: "is cool", so: %{is: "Bernie", and: {:system, "VARIABLE_VALUE"}})
      [bob: "BOB", harry: "is cool", so: %{is: "Bernie", and: "BOB"}]
  """
  def config_value(value) when is_map(value) do
    for tpl <- value, into: %{}, do: config_value(tpl)
  end

  def config_value([val|rest]) do
    [config_value(val) | config_value(rest)]
  end

  def config_value([]), do: []
  def config_value({:system, variable_name}), do: System.get_env(variable_name)
  def config_value({:system!, var}) do
    config_value({:system, var}) || raise(MissingEnvironmentVar, "Expected environment variable '#{var}'")
  end
  def config_value({key, value}), do: {key, config_value(value)}
  def config_value(value), do: value
end
