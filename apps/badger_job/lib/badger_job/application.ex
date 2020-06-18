defmodule BadgerJob.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      BadgerJob.Scheduler
    ]


    Supervisor.start_link(children, strategy: :one_for_one, name: BadgerJob.Supervisor)
  end
end
