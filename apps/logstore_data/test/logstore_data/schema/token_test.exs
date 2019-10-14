defmodule LogstoreData.Schema.TokenTest do
  use ExUnit.Case
  use LogstoreData.DataCase

  alias LogstoreData.Schema.Token

  setup do
    Repo.delete_all(Token)
    :ok 
  end

  test "greet the world" do
    assert "hello" == "hello"
  end

  describe "changesets" do
    test "accepts valid input" do
      tmap = %Token{}
      attr = %{key: "asdf"}
      cs = Token.changeset(tmap, attr)
      assert cs.valid?
    end
  end

  describe "inserting records" do
    test "adds a record" do
      tmap = %Token{}
      attr = %{key: "asdf"}
      cset = Token.changeset(tmap, attr)
      assert count(Token) == 0
      assert {:ok, _result} = Repo.insert(cset)
      assert count(Token) == 1
    end

    test "returns a record" do
      tmap = %Token{}
      attr = %{key: "asdf"}
      cset = Token.changeset(tmap, attr)
      tken = Repo.insert!(cset)
      assert count(Token) == 1
      assert tken.key == "asdf"
    end
  end

  describe "using Factory" do
    test "building an entity" do
      assert build(:token)
    end

    test "inserting an entity" do
      assert count(Token) == 0
      assert insert(:token)
      assert count(Token) == 1
    end

    test "inserting two entities" do
      assert count(Token) == 0
      assert insert(:token)
      assert insert(:token)
      assert count(Token) == 2
    end
  end

  describe "deleting records" do
    test "all feeds" do
      assert count(Token) == 0
      insert(:token)
      assert count(Token) == 1
      Repo.delete_all(Token)
      assert count(Token) == 0
    end
  end
end
