defmodule LogstoreData.Schema.Token do
  @moduledoc """
  Token schema
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "tokens" do
    field :key,   :string

    has_many :views, LogstoreData.Schema.View

    timestamps()
  end

  def changeset(token, params \\ %{}) do
    required_fields = [:key]
    optional_fields = []

    token
    |> cast(params, required_fields ++ optional_fields)
    |> validate_required(required_fields)
  end

  def new_changeset do
    changeset(%LogstoreData.Schema.Token{}, %{})
  end
end
