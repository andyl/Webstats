defmodule BadgerData.Schema.Downstream do
  @moduledoc """
  Downstream DataModel.
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias BadgerData.Schema.Downstream.Influx
  alias BadgerData.Schema.Downstream.Nats

  schema "downstreams" do
    field(:name, :string)
    field(:type, :string)
    field(:config, :map)
    field(:status, :string)
    field(:last_export_at, :utc_datetime)
    field(:cursor, :integer)
    timestamps(type: :utc_datetime)

    belongs_to :user, BadgerData.Schema.User
    has_many :exports, BadgerData.Schema.Export
  end

  @valid_types [
    "influx",
    "nats"
  ]

  def changeset(downstream, attrs) do
    required_fields = [:name, :type]
    optional_fields = [:status, :last_export_at, :cursor, :config]

    downstream
    |> cast(attrs, required_fields ++ optional_fields)
    |> validate_required(required_fields)
    |> validate_inclusion(:type, @valid_types)
    |> validate_config()
  end

  defp validate_config(changeset) do
    changeset
    |> build_config_changeset
    |> case do
      %{valid?: true} ->
        changeset

      %{errors: errors} ->
        add_data_errors(changeset, errors)
    end
  end

  defp embed_schema(type) do
    case type do
      "influx" -> {Influx, %Influx{}}
      "nats" -> {Nats, %Nats{}}
      _ -> raise("Unrecognized type (#{type})")
    end
  end

  defp build_config_changeset(changeset) do
    {schema, struct} = get_field(changeset, :type) |> embed_schema()
    config = get_field(changeset, :config)
    schema.changeset(struct, config)
  end

  defp add_data_errors(changeset, errors) do
    Enum.reduce(errors, changeset, fn {key, {message, meta}}, acc -> add_error(acc, key, message, meta) end)
  end

end
