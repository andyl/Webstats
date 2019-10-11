defmodule LogstoreData.Api.View do
  alias LogstoreData.Repo
  alias LogstoreData.Schema.View

  def create(opts, token: token) do
    vals = Map.merge(opts, %{token_id: token.id})

    tmap = %View{}
    cset = View.changeset(tmap, vals)
    Repo.insert!(cset)
  end
end

