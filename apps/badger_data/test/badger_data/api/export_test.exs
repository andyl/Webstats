defmodule BadgerData.Api.ExportTest do 
  use ExUnit.Case
  use BadgerData.DataCase

  alias BadgerData.Api.Export
  alias BadgerData.Schema

  setup do
    Repo.delete_all(Schema.Export)
    :ok 
  end

  describe "#export_add" do
    test "valid downstream" do
      attr = %{starting_record: 10, ending_record: 15, num_records: 4}
      assert count(Schema.Export)== 0
      Export.export_add(attr)
      assert count(Schema.Export) == 1
    end
  end
end
