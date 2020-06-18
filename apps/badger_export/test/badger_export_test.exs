defmodule BadgerExportTest do
  use ExUnit.Case
  doctest BadgerExport

  test "greets the world" do
    assert BadgerExport.hello() == :world
  end
end
