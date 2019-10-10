defmodule LogstoreData.Schema.Site do
  @moduledoc """
  Site DataModel.
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "sites" do
    field :name, :string
    field :url,  :integer

    has_many :views, LogstoreData.Schema.View
    
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:token, :visits])
    |> validate_required([:token, :visits])
  end
end
