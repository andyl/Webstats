defmodule LogstoreData.Api.ViewTest do
  use ExUnit.Case, async: true
  use LogstoreData.DataCase

  alias LogstoreData.Api
  alias LogstoreData.Schema

  describe "#create" do
    test "valid case" do
      token = Api.Token.create("asdf")
      assert count(Schema.View) == 0
      result = Api.View.create(%{}, token: token)
      assert count(Schema.View) == 1
      assert result.token_id == token.id
    end
  end
end
