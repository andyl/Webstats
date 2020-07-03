defmodule BadgerData.Schema.Downstream.Nats do
  @moduledoc """
  DataModel for Downstream/Nats.
  """
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :host, :string
    field :port, :string
    field :user, :string
    field :pass, :string
    field :db, :string
  end

  def changeset(config, attrs) do
    required_fields = [:host, :port, :user, :pass, :db]
    optional_fields = []

    config
    |> cast(attrs, required_fields ++ optional_fields)
    |> validate_required(required_fields)
  end
end
