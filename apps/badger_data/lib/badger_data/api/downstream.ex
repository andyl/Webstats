defmodule BadgerData.Api.Downstream do
  alias BadgerData.Schema.{Downstream, Export}
  alias BadgerData.Repo
  import Ecto.Query

  # ----- user_one -----

  def downstream_one do
    Repo.get_by(Downstream, id: 1) || 
      Downstream.changeset(%Downstream{}, %{name: "aaa"}) |> Repo.insert!()
  end

  # ----- queries -----

  def exports(downstream_id) do
    from(export in Export,
      where: export.downstream_id == ^downstream_id,
      order_by: export.id,
      select: %{
        export_id: export.id,
        export_name: export.name,
        export_url: export.url
      }
    )
    |> Repo.all()
  end

  # ----- downstreams -----

  def downstream_list do
    Repo.all(Downstream)
  end

  def downstream_get(downstream_id) do
    Repo.get(Downstream, downstream_id)
  end

  def downstream_get_by(params) do
    Repo.get_by(Downstream, params)
  end

  def downstream_add(opts) do
    %Downstream{}
    |> Downstream.changeset(opts)
    |> Repo.insert()
  end

  def downstream_changeset(%Downstream{} = downstream) do
    Downstream.changeset(downstream, %{})
  end

  def downstream_change(_downstream_id) do
  end

  def downstream_delete(_downstream_id) do
  end
end
