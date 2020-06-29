defmodule BadgerData.Schema.Token do
  @moduledoc """
  Token schema
  """
  use Ecto.Schema

  alias BadgerData.Api.Site
  import Ecto.Changeset

  schema "tokens" do
    field :key,   :string
    field :req_tag, :string
    field :path,  :string

    belongs_to :site, BadgerData.Schema.Site
    has_many :views, BadgerData.Schema.View

    timestamps()
  end

  def changeset(token, params \\ %{}) do
    required_fields = [:key]
    optional_fields = [:path, :site_id, :req_tag]

    token
    |> cast(params, required_fields ++ optional_fields)
    |> set_site_id()
    |> validate_required(required_fields)
  end

  def new_changeset do
    changeset(%BadgerData.Schema.Token{}, %{})
  end

  def set_site_id(changeset) do
    site = changeset |> get_change(:req_tag) |> Site.get_by_tag()
    changeset |> put_change(:site_id, site.id)
  end
end
