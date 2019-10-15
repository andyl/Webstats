defmodule BadgerData.Schema.ViewTest do
  use ExUnit.Case
  use BadgerData.DataCase

  alias BadgerData.Schema.View

  setup do
    Repo.delete_all(View)
    :ok 
  end

  test "greet the world" do
    assert "hello" == "hello"
  end

  describe "changesets" do
    test "accepts valid input" do
      tmap = %View{}
      attr = %{}
      cs = View.changeset(tmap, attr)
      assert cs.valid?
    end
  end

  describe "inserting records" do
    test "adds a record" do
      tmap = %View{}
      attr = %{}
      cset = View.changeset(tmap, attr)
      assert count(View) == 0
      assert {:ok, _result} = Repo.insert(cset)
      assert count(View) == 1
    end
  end

  describe "inserting fields" do
    test "using client_ip" do
      tmap = %View{}
      attr = %{client_ip: "xxxx"}
      cset = View.changeset(tmap, attr)
      assert count(View) == 0
      assert {:ok, _result} = Repo.insert(cset)
      assert count(View) == 1
    end

    test "using client_ua" do
      tmap = %View{}
      attr = %{client_ua: "xxxxx"}
      cset = View.changeset(tmap, attr)
      assert count(View) == 0
      assert {:ok, _result} = Repo.insert(cset)
      assert count(View) == 1
    end

    test "using both" do
      tmap = %View{}
      attr = %{client_ip: "qwer", client_ua: "xxxxx"}
      cset = View.changeset(tmap, attr)
      assert count(View) == 0
      assert {:ok, _result} = Repo.insert(cset)
      assert count(View) == 1
    end
  end

  describe "using Factory" do
    test "building an entity" do
      assert build(:view)
    end

    test "inserting an entity" do
      assert count(View) == 0
      assert insert(:view)
      assert count(View) == 1
    end

    test "inserting two entities" do
      assert count(View) == 0
      assert insert(:view)
      assert insert(:view)
      assert count(View) == 2
    end
  end

  describe "deleting records" do
    test "all feeds" do
      assert count(View) == 0
      insert(:view)
      assert count(View) == 1
      Repo.delete_all(View)
      assert count(View) == 0
    end
  end
end
