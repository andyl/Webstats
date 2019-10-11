defmodule LogstoreData.Api.TokenTest do
  use ExUnit.Case, async: true
  use LogstoreData.DataCase

  alias LogstoreData.Api
  alias LogstoreData.Schema

  setup do
    Repo.delete_all(Schema.Token)
    :ok 
  end

  describe "#create/0" do
    test "valid case" do
      assert count(Schema.Token) == 0
      Api.Token.create()
      assert count(Schema.Token) == 1
    end
  end

  describe "#create/1" do
    test "valid case" do
      assert count(Schema.Token) == 0
      result = Api.Token.create("asdf")
      assert count(Schema.Token) == 1
      assert result.key == "asdf"
    end
  end

  describe "#get_by_key" do
    test "valid key" do
      Api.Token.create("asdf")
      result = Api.Token.get_by_key("asdf")
      assert result.key == "asdf"
    end

    test "invalid key" do
      result = Api.Token.get_by_key("asdf")
      assert result == nil
    end
  end

  describe "#find_or_create" do
    test "valid key" do
      Api.Token.create("zxcv")
      result = Api.Token.find_or_create("zxcv")
      refute result == nil
      assert result.key == "zxcv"
    end

    test "empty key" do
      result = Api.Token.find_or_create([])
      refute result == nil
    end

    test "valid key in list" do
      Api.Token.create("zxcv")
      result = Api.Token.find_or_create(["zxcv"])
      refute result == nil
      assert result.key == "zxcv"
    end
  end
end
