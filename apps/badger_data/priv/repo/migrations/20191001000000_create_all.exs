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
  end
end
