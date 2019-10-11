defmodule LogstoreWeb.PageControllerTest do
  use LogstoreWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Logstore"
  end
end
