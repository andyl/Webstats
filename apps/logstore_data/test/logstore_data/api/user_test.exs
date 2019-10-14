defmodule LogstoreData.Api.UserTest do 
  use ExUnit.Case
  use LogstoreData.DataCase

  alias LogstoreData.Api.User
  alias LogstoreData.Schema

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
