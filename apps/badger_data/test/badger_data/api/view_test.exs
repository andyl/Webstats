defmodule BadgerData.Api.ViewTest do
  use ExUnit.Case
  use BadgerData.DataCase

  alias BadgerData.Api
  alias BadgerData.Schema

  describe "#create" do
    test "valid case" do
      token = Api.Token.create("asdf", %{})
      assert count(Schema.View) == 0
      result = Api.View.create(%{}, token: token)
      assert count(Schema.View) == 1
      assert result.token_id == token.id
    end

    test "with client_ip" do
      token = Api.Token.create("asdf", %{})
      assert count(Schema.View) == 0
      result = Api.View.create(%{client_ip: "asdf"}, token: token)
      assert count(Schema.View) == 1
      assert result.token_id == token.id
    end

    test "with client_ua" do
      token = Api.Token.create("asdf", %{})
      assert count(Schema.View) == 0
      result = Api.View.create(%{client_ua: "asdf"}, token: token)
      assert count(Schema.View) == 1
      assert result.token_id == token.id
    end

    test "with both" do
      token = Api.Token.create("asdf", %{})
      assert count(Schema.View) == 0
      result = Api.View.create(%{client_ip: "qwer", client_ua: "asdf"}, token: token)
      assert count(Schema.View) == 1
      assert result.token_id == token.id
    end
  end
end
