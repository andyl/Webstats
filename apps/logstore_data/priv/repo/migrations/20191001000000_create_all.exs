defmodule LogstoreData.Repo.Migrations.CreateAll do
  use Ecto.Migration

  def change do
    create table(:sites) do
      add :name, :string
      add :url,  :string
      timestamps()
    end

    create table(:tokens) do
      add :key, :string
      timestamps()
    end

    create index(:tokens, [:key])

    create table(:views) do
      add :site_id,    references(:sites)
      add :token_id,   references(:tokens)
      add :client_ip,  :string
      add :client_ua,  :string
      timestamps()
    end
  end
end

