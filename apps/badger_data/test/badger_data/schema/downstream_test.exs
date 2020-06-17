defmodule BadgerData.Schema.DownstreamTest do
  use ExUnit.Case
  use BadgerData.DataCase

  alias BadgerData.Schema.Downstream

  setup do
    Repo.delete_all(Downstream)
    :ok 
  end

  test "greet the world" do
    assert "hello" == "hello"
  end

  describe "changesets" do
    test "accepts valid input" do
      tmap = %Downstream{}
      attr = %{name: "aa", type: "bb", address: "cc", credentials: "dd"}
      cs = Downstream.changeset(tmap, attr)
      assert cs.valid?
    end
  end

  describe "inserting records" do
    test "adds a record" do
      tmap = %Downstream{}
      attr = %{name: "aa", type: "bb", address: "cc", credentials: "dd"}
      cset = Downstream.changeset(tmap, attr)
      assert count(Downstream) == 0
      assert {:ok, _result} = Repo.insert(cset)
      assert count(Downstream) == 1
    end
  end

  describe "using Factory" do
    test "building an entity" do
      assert build(:downstream)
    end

    test "inserting an entity" do
      assert count(Downstream) == 0
      assert insert(:downstream)
      assert count(Downstream) == 1
    end

    test "inserting two entities" do
      assert count(Downstream) == 0
      assert insert(:downstream)
      assert insert(:downstream)
      assert count(Downstream) == 2
    end
  end

  describe "deleting records" do
    test "all feeds" do
      assert count(Downstream) == 0
      insert(:downstream)
      assert count(Downstream) == 1
      Repo.delete_all(Downstream)
      assert count(Downstream) == 0
    end
  end
end
