defmodule BadgerData.Api.Export do
  alias BadgerData.Schema.Export
  alias BadgerData.Repo
  
  # ----- exports -----

  def export_list do
    Repo.all(Export)
  end

  def export_get(export_id) do
    Repo.get(Export, export_id)
  end

  def export_get_by(params) do
    Repo.get_by(Export, params)
  end

  def export_add(opts) do
    %Export{}
    |> Export.changeset(opts)
    |> Repo.insert()
  end

  def export_changeset(%Export{} = export) do
    Export.changeset(export, %{})
  end

  def export_change(_export_id) do
  end

  def export_delete(_export_id) do
  end
end
