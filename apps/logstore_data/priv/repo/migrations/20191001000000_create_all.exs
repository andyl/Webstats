defmodule LogstoreData.Repo.Migrations.CreateAll do
  use Ecto.Migration

  def change do
    create table(:sites) do
      add :name, :string
      add :url,  :string
    end

    create table(:views) do
      add :site_id, references(:sites)
      add :token,   :string
      add :cip,     :string
      add :cua,     :string
      timestamps()
    end
  end
end

