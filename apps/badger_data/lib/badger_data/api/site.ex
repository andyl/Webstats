defmodule BadgerData.Api.Site do
  alias BadgerData.Repo
  alias BadgerData.Schema.Site

  import Ecto.Query

  # ----- defined sites -----

  defp new_site(name, url) do
    new_site(name, url, Site.tag_for_name(name))
  end

  defp new_site(name, url, tag) do
    Site.changeset(
      %Site{},
      %{
        url: url,
        name: name,
        tag: tag
      }
    )
  end

  def badger_host do
    Repo.get_by(Site, name: "badger_host") || 
      new_site("badger_host", "http://localhost", Application.get_env(:badger_web, :badger_tag)) |> Repo.insert!()
  end

  def badger_404 do
    Repo.get_by(Site, name: "badger_404") || 
      new_site("badger_404", "http://tbd") |> Repo.insert!()
  end

  # ----- queries -----
  
  def create(opts \\ %{}) do
    Site.changeset(%Site{}, opts) |> Repo.insert!()
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

  def site_get(site_id) do
    Repo.get(Site, site_id)
  end

  def get_by_id(id) do
    Site |> Repo.get_by(id: id)
  end

  def get_by_tag(tag) do
    case tag do
      nil -> badger_404()
      "" -> badger_404()
      _ -> Repo.get_by(Site, tag: tag) || badger_404()
    end
  end
end
