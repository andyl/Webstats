defmodule BadgerData.Repo.Migrations.CreateAll do
  use Ecto.Migration

  def change do
    create table(:users) do
      add(:name, :string)
      add(:email, :string)
      add(:admin, :boolean)
      add(:pwd_hash, :string)
      add(:auth_token, :string)
      add(:last_seen_at, :utc_datetime)
      timestamps(type: :utc_datetime)
    end

    create table(:sites) do
      add :user_id, references(:users, on_delete: :delete_all)
      add :name, :string
      add :url, :string
      add :type, :string
      add :pubid, :string
      timestamps()
    end

    create table(:tokens) do
      add :site_id, references(:sites, on_delete: :delete_all)
      add :key, :string
      add :path, :string
      timestamps()
    end

    create index(:tokens, [:key])

    create table(:views) do
      add :token_id, references(:tokens, on_delete: :delete_all)
      add :client_ip, :string
      add :client_ua, :string
      timestamps()
    end

    create table(:downstreams) do
      add :user_id, references(:users, on_delete: :delete_all)
      add :name, :string
      add :type, :string
      add :address, :string
      add :credentials, :string
      add :status, :string
      add :last_export_at, :utc_datetime
      add :cursor, :integer
      timestamps()
    end

    create table(:exports) do
      add :downstream_id, references(:downstreams, on_delete: :delete_all)
      add :starting_record, :integer
      add :ending_record, :integer
      add :num_records, :integer
      add :started_at, :utc_datetime
      add :finished_at, :utc_datetime
      timestamps()
    end
  end
end
