defmodule BadgerData.Schema.Export do
  @moduledoc """
  Export DataModel.
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "exports" do
    field(:starting_record, :integer)
    field(:ending_record, :integer)
    field(:num_records, :integer)
    field(:started_at, :utc_datetime)
    field(:finished_at, :utc_datetime)
    timestamps(type: :utc_datetime)

    belongs_to :downstream, BadgerData.Schema.Downstream
  end

  def changeset(downstream, attrs) do
    required_fields = [:starting_record, :ending_record, :num_records]
    optional_fields = [:id, :started_at, :finished_at]

    downstream
    |> cast(attrs, required_fields ++ optional_fields)
    |> validate_required(required_fields)
  end
end
