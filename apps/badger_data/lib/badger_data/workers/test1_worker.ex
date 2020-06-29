defmodule BadgerData.Workers.Test1Worker do
  use Oban.Worker, queue: :serial

  @impl Oban.Worker
  def perform(args) do

    IO.inspect "++++++++++++++++++++++++++++++++"
    IO.inspect args

    :ok
  end
end
