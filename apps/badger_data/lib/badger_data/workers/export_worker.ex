defmodule BadgerData.Workers.ExportWorker do
  use Oban.Worker, queue: :serial

  alias BadgerData.Api.{User, View, Site, Token}

  @impl Oban.Worker
  def perform(job) do

    elapsed = job.args["elapsed"]
    view = View.view_get(job.args["view_id"])
    token = Token.token_get(view.token_id)
    site = Site.site_get(token.site_id)
    user = User.user_get(site.user_id)
    downstreams = User.downstreams(user.id)

    for downstream <- downstreams do
      tags = %{
        view_path: token.path,
        site_id: site.id, 
        site_name: site.name,
        user_name: user.name
      }
      config = downstream.config
      export = fn() -> 
        case downstream.type do
        "influx" -> BadgerData.Exporters.Influx.write(elapsed, tags, config)
        _ -> raise("Unknown downstream type (#{downstream.type})")
        end
      end
      {elapsed, result} = :timer.tc(export, [])

      ex_opts = %{
        elapsed_time: elapsed,
        status: inspect(result)
      }
      BadgerData.Api.Export.export_add(ex_opts)

      ds_opts = %{
        cursor: view.id
      }
      BadgerData.Api.Downstream.downstream_update(downstream.id, ds_opts)
    end

    :ok
  end
end
