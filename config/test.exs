import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :ant_colony, AntColony.Repo,
  username: "postgres",
  password: "postgres",
  database: "ant_colony_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :ant_colony, AntColonyWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "61EegEUX3N80o7lV3QK5Bf09q1gVndRu+vfAObALJCnX6z15pWkIgaN/qTd4QD1l",
  server: false

# In test we don't send emails.
config :ant_colony, AntColony.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
