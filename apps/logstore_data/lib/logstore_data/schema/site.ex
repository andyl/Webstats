defmodule LogstoreData.Schema.Site do
  @moduledoc """
  Site schema
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "sites" do
    field :name, :string
    field :url,  :string

    belongs_to :user, LogstoreData.Schema.User
    has_many :tokens, LogstoreData.Schema.Token

    timestamps()
  end

  def changeset(site, params \\ %{}) do
    required_fields = [:name]
    optional_fields = [:url]

    site
    |> cast(params, required_fields ++ optional_fields)
    |> validate_required(required_fields)
  end

  def new_changeset do
    changeset(%LogstoreData.Schema.Site{}, %{})
  end
end
