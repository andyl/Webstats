defmodule BadgerData.Api.View do
  alias BadgerData.Repo
  alias BadgerData.Schema.View

  def view_get(view_id) do
    Repo.get(View, view_id)
  end

  # opts: client_ip and client_ua
  def create(opts, token: token) do
    vals = Map.merge(opts, %{token_id: token.id})

    cset = View.changeset(%View{}, vals)
    Repo.insert!(cset)
  end
end

