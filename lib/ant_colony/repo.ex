defmodule AntColony.Repo do
  use Ecto.Repo,
    otp_app: :ant_colony,
    adapter: Ecto.Adapters.Postgres
end
