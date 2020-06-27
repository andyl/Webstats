defmodule BadgerData.Api.Site do
  alias BadgerData.Repo
  alias BadgerData.Schema.Site

  import Ecto.Query

  # ----- defined sites -----

  defp new_site(name, url) do
    Site.changeset(
      %Site{},
      %Site{
        url: url,
        name: name,
        tag: Site.tag_for_name(name)
      }
    )
  end

  def badger_host do
    Repo.get_by(Site, name: "badger_host") || 
      new_site("badger_host", "http://localhost") |> Repo.insert!()
  end

  def badger_404 do
    Repo.get_by(Site, name: "badger_404") || 
      new_site("badger_404", "http://tbd") |> Repo.insert!()
  end

  # ----- queries -----
  
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
    )
    |> Repo.one()
  end

  def apphost do
    host = System.get_env("SYSNAME", "localhost")
    uid  = BadgerData.Api.User.user_one().id

    Repo.get_by(Site, name: host, user_id: uid) || create(%{name: host, user_id: uid})
  end

  def apphost_id do
    apphost().id
  end

  def get_by_id(id) do
    Site |> Repo.get_by(id: id)
  end
end
