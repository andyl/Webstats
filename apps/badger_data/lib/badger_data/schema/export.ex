defmodule BadgerData.Schema.Export do
  @moduledoc """
  Export DataModel.
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "exports" do
    field(:elapsed_time, :integer)
    field(:status, :string)
    timestamps(type: :utc_datetime)

    belongs_to :downstream, BadgerData.Schema.Downstream
  end

  def changeset(downstream, attrs) do
    required_fields = []
    optional_fields = [:downstream_id, :elapsed_time, :status]

    downstream
    |> cast(attrs, required_fields ++ optional_fields)
    |> validate_required(required_fields)
  end
end
