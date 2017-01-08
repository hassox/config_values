# ConfigValues

Standardizes configuration values so that you can use system variables etc.

### Example

```elixir
config :my_app, SomeModule,
  some_value: {:system, "VARIABLE_NAME"},
  other_value: "normal_value"
```

In your library or code, when loading values from config pass them through
config values. The following are replaced with their values:

* `{:system, "VARIABLE_NAME"}` - replaces with a call to `System.get_env("VARIABLE_NAME")`

In case a variable is mandatory and you want to raise an exception when it is missing, you can use
* `{:system!, "MANDATORY_VARIABLE_NAME"}`


```elixir

# Assume that there is a system variable in "VARIABLE_NAME" of "BOB"
my_config = Application.get_env(:my_app, SomeModule) |> ConfigValues.config_value


[
  some_value: "BOB",
  other_value: "normal_value",
]
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add config_values to your list of dependencies in `mix.exs`:

        def deps do
          [{:config_values, "~> 1.0.0"}]
        end

  2. Ensure config_values is started before your application:

        def application do
          [applications: [:config_values]]
        end

