defmodule LogstoreData.Schema.View do
  @moduledoc """
  Visit schema
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "views" do
    field :client_ip,     :string
    field :client_ua,     :string

    belongs_to :site, LogstoreData.Schema.Site
    belongs_to :token, LogstoreData.Schema.Token

    timestamps()
  end

  def changeset(view, params \\ %{}) do
    required_fields = []
    optional_fields = [:token_id, :site_id, :client_ip, :client_ua, :site_id]

    view
    |> cast(params, required_fields ++ optional_fields)
    |> validate_required(required_fields)
  end

  def new_changeset do
    changeset(%LogstoreData.Schema.View{}, %{})
  end
end
