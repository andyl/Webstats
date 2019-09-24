defmodule WebstatsWeb.PageControllerTest do
  use WebstatsWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Webstats"
  end
end
