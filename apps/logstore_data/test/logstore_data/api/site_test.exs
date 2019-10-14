defmodule LogstoreData.Api.SiteTest do
  use ExUnit.Case, async: true
  use LogstoreData.DataCase


  alias LogstoreData.Api
  alias LogstoreData.Schema

  setup do
    Repo.delete_all(Schema.Site)
    :ok 
  end

  describe "HelloWorld" do
    test "basic" do
      assert 1 == 1
    end
  end

  describe "#create/0" do
    test "valid case" do
      assert count(Schema.Site) == 0
      Api.Site.create(%{name: "asdf"})
      assert count(Schema.Site) == 1
    end
  end

  describe "#apphost/0" do
    test "creation generates a site record" do
      assert count(Schema.Site) == 0
      Api.Site.apphost()
      assert count(Schema.Site) == 1
    end

    test "reuse doesn't generate another site record" do
      assert count(Schema.Site) == 0
      Api.Site.apphost()
      Api.Site.apphost()
      assert count(Schema.Site) == 1
    end

    test "apphost name" do
      assert count(Schema.Site) == 0
      site = Api.Site.apphost()
      name = System.get_env("SYSNAME", "localhost")
      assert site.name == name
    end
  end

  describe "#apphost_id/0" do
    test "returns a number" do
      assert is_number(Api.Site.apphost_id())
    end
  end

  describe "#first_id" do
    test "valid case" do
      assert count(Schema.Site) == 0
      site = Api.Site.create(%{name: "asdf"})
      sid  = Api.Site.first_id()
      assert site.id == sid
    end
  end
end
