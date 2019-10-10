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

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:token])
    |> validate_required([:token])
  end
end
