# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :timer_socket, TimerSocket.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "J2bK/alwkXp5LT5ne7ISpUEV7gvcCQNg4t33qT0bR3jhE8hA2dnIInkgiBd6s/AQ",
  render_errors: [view: TimerSocket.ErrorView, accepts: ~w(html json)],
  pubsub: [name: TimerSocket.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
