defmodule BadgerData.Schema.ExportTest do
  use ExUnit.Case
  use BadgerData.DataCase

  alias BadgerData.Schema.Export

  setup do
    Repo.delete_all(Export)
    :ok 
  end

  test "greet the world" do
    assert "hello" == "hello"
  end

  describe "changesets" do
    test "accepts valid input" do
      tmap = %Export{}
      attr = %{status: "ok", cursor: 10}
      cs = Export.changeset(tmap, attr)
      assert cs.valid?
    end
  end

  describe "inserting records" do
    test "adds a record" do
      tmap = %Export{}
      attr = %{status: "ok", cursor: 10}
      cset = Export.changeset(tmap, attr)
      assert count(Export) == 0
      assert {:ok, _result} = Repo.insert(cset)
      assert count(Export) == 1
    end
  end

  describe "using Factory" do
    test "building an entity" do
      assert build(:export)
    end

    test "inserting an entity" do
      assert count(Export) == 0
      assert insert(:export)
      assert count(Export) == 1
    end

    test "inserting two entities" do
      assert count(Export) == 0
      assert insert(:export)
      assert insert(:export)
      assert count(Export) == 2
    end
  end

  describe "deleting records" do
    test "all feeds" do
      assert count(Export) == 0
      insert(:export)
      assert count(Export) == 1
      Repo.delete_all(Export)
      assert count(Export) == 0
    end
  end
end
