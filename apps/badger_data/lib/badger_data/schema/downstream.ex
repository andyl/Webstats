defmodule BadgerData.Schema.Downstream do
  @moduledoc """
  Downstream DataModel.
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "downstreams" do
    field(:name, :string)
    field(:type, :string)
    field(:address, :string)
    field(:credentials, :string)
    field(:status, :string)
    field(:last_export_at, :utc_datetime)
    timestamps(type: :utc_datetime)

    belongs_to :user, BadgerData.Schema.User
    has_many :exports, BadgerData.Schema.Export
  end

  def changeset(downstream, attrs) do
    required_fields = [:name, :type, :address, :credentials]
    optional_fields = [:id, :status, :last_export_at]

    downstream
    |> cast(attrs, required_fields ++ optional_fields)
    |> validate_required(required_fields)
  end
end
