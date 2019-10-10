defmodule LogstoreData.Schema.View do
  @moduledoc """
  Visit DataModel.
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "views" do
    field :token,   :string
    field :cip,     :string
    field :cua,     :string

    belongs_to :site, LogstoreData.Schema.Site

    timestamps()
  end

  def changeset(view, params \\ %{}) do
    required_fields = [:token]
    optional_fields = [:cip, :cua, :site_id]

    view
    |> cast(params, required_fields ++ optional_fields)
    |> validate_required(required_fields)
  end

  def new_changeset do
    changeset(%LogstoreData.Schema.View{}, %{})
  end
end
