defmodule BadgerData.Api.DownstreamTest do 
  use ExUnit.Case
  use BadgerData.DataCase

  alias BadgerData.Api.Downstream
  alias BadgerData.Schema

  setup do
    Repo.delete_all(Schema.Downstream)
    :ok 
  end

  @conf %{host: "x", db: "y", pass: "z", user: "a", port: "b"}
  @attr %{name: "aa", type: "influx", config: @conf}

  describe "#downstream_add" do
    test "valid downstream" do
      assert count(Schema.Downstream)== 0
      Downstream.downstream_add(@attr)
      assert count(Schema.Downstream) == 1
    end
  end
end

