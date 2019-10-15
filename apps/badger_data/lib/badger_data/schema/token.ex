defmodule BadgerData.Schema.Token do
  @moduledoc """
  Token schema
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "tokens" do
    field :key,   :string
    field :path,  :string

    belongs_to :site, BadgerData.Schema.Site
    has_many :views, BadgerData.Schema.View

    timestamps()
  end

  def changeset(token, params \\ %{}) do
    required_fields = [:key]
    optional_fields = [:path, :site_id]

    token
    |> cast(params, required_fields ++ optional_fields)
    |> validate_required(required_fields)
  end

  def new_changeset do
    changeset(%BadgerData.Schema.Token{}, %{})
  end
end
