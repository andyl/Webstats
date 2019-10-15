defmodule BadgerData.Schema.View do
  @moduledoc """
  Visit schema
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "views" do
    field :client_ip,     :string
    field :client_ua,     :string

    belongs_to :token, BadgerData.Schema.Token

    timestamps()
  end

  def changeset(view, params \\ %{}) do
    required_fields = []
    optional_fields = [:token_id, :client_ip, :client_ua]

    view
    |> cast(params, required_fields ++ optional_fields)
    |> validate_required(required_fields)
  end

  def new_changeset do
    changeset(%BadgerData.Schema.View{}, %{})
  end
end
