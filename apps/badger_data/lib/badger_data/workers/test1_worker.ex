defmodule BadgerData.Workers.Test1Worker do
  use Oban.Worker, queue: :serial

  @impl Oban.Worker
  def perform(args) do

    # TODO:
    # - lookup downstreams
    # - for every downstream, run an exporter

    IO.inspect "++++++++++++++++++++++++++++++++"
    IO.inspect args

    :ok
  end
end
