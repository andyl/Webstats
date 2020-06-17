defmodule BadgerData.Api.UserTest do 
  use ExUnit.Case
  use BadgerData.DataCase

  alias BadgerData.Api.User
  alias BadgerData.Schema

  setup do
    Repo.delete_all(Schema.User)
    :ok 
  end

  describe "#user_add" do
    test "valid user" do
      attr = %{name: "asdf", email: "qwer.com", pwd: "bingbing"}
      assert count(Schema.User)== 0
      User.user_add(attr)
      assert count(Schema.User) == 1
    end

    test "missing password error" do
      attr = %{name: "asdf", email: "qwer.com"}
      assert count(Schema.User) == 0
      User.user_add(attr)
      assert count(Schema.User) == 1
    end
  end
end
