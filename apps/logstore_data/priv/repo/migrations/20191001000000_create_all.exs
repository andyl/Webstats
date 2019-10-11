defmodule LogstoreData.Repo.Migrations.CreateAll do
  use Ecto.Migration

  def change do
    create table(:sites) do
      add :name, :string
      add :url,  :string
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
      add :token_id,   references(:tokens, on_delete: :delete_all)
      add :client_ip,  :string
      add :client_ua,  :string
      timestamps()
    end
  end
end

