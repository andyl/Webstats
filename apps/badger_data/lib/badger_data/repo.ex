defmodule BadgerData.Repo do
  use Ecto.Repo,
    otp_app: :badger_data,
    adapter: Ecto.Adapters.Postgres
end
