defmodule BadgerData.Schema.Site do
  @moduledoc """
  Site schema
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "sites" do
    field :name, :string
    field :url,  :string
    field :tag,  :string

    belongs_to :user, BadgerData.Schema.User
    has_many :tokens, BadgerData.Schema.Token

    timestamps()
  end

  def changeset(site, params \\ %{}) do
    required_fields = [:name, :tag]
    optional_fields = [:url, :user_id]

    site
    |> cast(params, required_fields ++ optional_fields)
    |> unique_constraint(:name)
    |> unique_constraint(:tag)
    |> set_tag_if_empty()
    |> validate_required(required_fields)
  end

  def new_changeset do
    changeset(%BadgerData.Schema.Site{}, %{})
  end

  def tag_for_name(name) do
    System.monotonic_time(:nanosecond) 
    |> Integer.to_string(16)
    |> concat(name)
    |> :erlang.md5()
    |> Base.encode16()
    |> String.slice(-6..-1) 
    |> String.downcase()
  end

  defp set_tag_if_empty(changeset) do
    case get_change(changeset, :tag) do
      nil -> put_change(changeset, :tag, tag_for_changeset(changeset))
      ""  -> put_change(changeset, :tag, tag_for_changeset(changeset))
      _   -> changeset
    end
  end

  defp tag_for_changeset(changeset) do
    changeset
    |> get_change(:name)
    |> tag_for_name()
  end

  defp concat(string1, string2) do
    string1 <> string2
  end
end
