defmodule BadgerData.Repo.Migrations.CreateAll do
  use Ecto.Migration

  def change do
    # for user sessions
    create table(:users) do
      add(:name, :string)
      add(:email, :string)
      add(:admin, :boolean)
      add(:pwd_hash, :string)
      add(:auth_token, :string)
      add(:last_seen_at, :utc_datetime)
      timestamps(type: :utc_datetime)
    end

    # one record for each site
    create table(:sites) do
      add :user_id, references(:users, on_delete: :delete_all)
      add :name, :string
      add :url, :string
      add :type, :string
      add :tag, :string
      timestamps()
    end

    create index(:sites, [:name])
    create index(:sites, [:tag])

    # holds etag tokens
    create table(:tokens) do
      add :site_id, references(:sites, on_delete: :delete_all)
      add :req_tag, :string
      add :key, :string
      add :path, :string
      timestamps()
    end

    create index(:tokens, [:key])

    # holds a record for each view
    create table(:views) do
      add :token_id, references(:tokens, on_delete: :delete_all)
      add :client_ip, :string
      add :client_ua, :string
      timestamps()
    end

    # downstream systems (influx, nats, kafka, rabbitmq, etc.)
    create table(:downstreams) do
      add :user_id, references(:users, on_delete: :delete_all)
      add :name, :string
      add :type, :string
      add :config, :map
      add :status, :string
      add :cursor, :integer
      timestamps()
    end

    # one record for each export job
    create table(:exports) do
      add :downstream_id, references(:downstreams, on_delete: :delete_all)
      add :elapsed_time, :integer
      add :status, :string
      timestamps()
    end
  end
end
