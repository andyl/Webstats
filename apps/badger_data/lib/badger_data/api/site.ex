defmodule BadgerData.Api.Site do
  alias BadgerData.Repo
  alias BadgerData.Schema.Site

  import Ecto.Query

  def create(opts \\ %{}) do
    Site.changeset(%Site{}, opts)
    |> Repo.insert!()
  end

  def first_id do
    from(
      s in Site,
      select: s.id,
      order_by: s.id,
      limit: 1
    ) |> Repo.one()
  end

  def apphost do
    host = System.get_env("SYSNAME", "localhost")
    Repo.get_by(Site, name: host) || create(%{name: host})
  end

  def apphost_id do
    apphost().id
  end

  def get_by_id(id) do
    Site |> Repo.get_by(id: id)
  end
end
