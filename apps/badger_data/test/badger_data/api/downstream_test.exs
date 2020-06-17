defmodule BadgerData.Api.DownstreamTest do 
  use ExUnit.Case
  use BadgerData.DataCase

  alias BadgerData.Api.Downstream
  alias BadgerData.Schema

  setup do
    Repo.delete_all(Schema.Downstream)
    :ok 
  end

  describe "#downstream_add" do
    test "valid downstream" do
      attr = %{name: "aa", address: "bb", type: "cc", credentials: "dd"}
      assert count(Schema.Downstream)== 0
      Downstream.downstream_add(attr)
      assert count(Schema.Downstream) == 1
    end
  end
end
