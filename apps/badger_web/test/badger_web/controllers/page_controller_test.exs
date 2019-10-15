defmodule BadgerWeb.PageControllerTest do
  use BadgerWeb.ConnCase
  use BadgerData.DataCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Badger"
  end
end
