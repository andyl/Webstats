defmodule LogstoreData.Repo do
  use Ecto.Repo,
    otp_app: :logstore_data,
    adapter: Ecto.Adapters.Postgres
end
