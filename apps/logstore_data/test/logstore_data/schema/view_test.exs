defmodule LogstoreData.Schema.ViewTest do 
  use ExUnit.Case, async: true
  use LogstoreData.DataCase

  alias LogstoreData.Schema.View

  test "greet the world" do
    assert "hello" == "hello"
  end

  describe "changesets" do
    test "accepts valid input" do
      tmap = %View{}
      attr = %{url: "asdf"}
      cs = View.changeset(tmap, attr)
      assert cs.valid?
    end
  end

  # describe "inserting records" do
  #   test "adds a record" do
  #     tmap = %View{}
  #     attr = %{url: "asdf"}
  #     cset = View.changeset(tmap, attr)
  #     assert count(View) == 0
  #     assert {:ok, _result} = Repo.insert(cset)
  #     assert count(View) == 1
  #   end
  # end
  #
  # describe "using Factory" do
  #   test "building an entity" do
  #     assert build(:feed)
  #   end
  #
  #   test "inserting an entity" do
  #     assert count(View) == 0
  #     assert insert(:feed)
  #     assert count(View) == 1
  #   end
  #
  #   test "inserting two entities" do
  #     assert count(View) == 0
  #     assert insert(:feed)
  #     assert insert(:feed)
  #     assert count(View) == 2
  #   end
  #
  #   test "uses alternate attrs" do
  #     altname = "NEWNAME"
  #     assert count(View) == 0
  #     assert trak = insert(:feed, %{url: altname})
  #     assert count(View) == 1
  #     assert trak.url == altname
  #   end
  # end
  #
  # describe "deleting records" do
  #   test "all feeds" do
  #     assert count(View) == 0
  #     insert(:feed)
  #     assert count(View) == 1
  #     Repo.delete_all(View)
  #     assert count(View) == 0
  #   end
  # end
end
