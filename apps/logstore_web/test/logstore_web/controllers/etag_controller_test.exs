defmodule LogstoreWeb.EtagControllerTest do
  use LogstoreWeb.ConnCase
  use LogstoreData.DataCase

  alias LogstoreData.Schema

  setup do
    Repo.delete_all(Schema.View)
    Repo.delete_all(Schema.Token)
    :ok
  end

  # basic response
  test "GET /png0/1", %{conn: conn} do
    conn = get(conn, "/png0/1")
    assert response(conn, 200)
  end

  # one query - check for database objects
  test "GET /png0/2", %{conn: conn} do
    assert count(Schema.View) == 0
    assert count(Schema.Token) == 0
    conn = get(conn, "/png0/2")
    assert response(conn, 200) 
    assert count(Schema.View) == 1
    assert count(Schema.Token) == 1
  end

  # two queries - check for multiple database objects
  test "GET /png0/3", %{conn: conn} do
    assert count(Schema.Token) == 0
    assert count(Schema.View) == 0
    get(conn, "/png0/3")
    get(conn, "/png0/3")
    assert count(Schema.Token) == 2
    assert count(Schema.View) == 2
  end

  # two queries with etag - check for reuse of Token
  test "GET /png0/4", %{conn: conn} do
    assert count(Schema.Token) == 0
    assert count(Schema.View) == 0
    resp = get(conn, "/png0/4")
    altconn(conn, resp) |> get("/png0/4")
    assert count(Schema.Token) == 1
    assert count(Schema.View) == 2
  end

  # ---------------------------------------------------------

  defp altconn(conn, resp) do
    case etag_for(resp) do
      nil -> conn
      tag -> Plug.Conn.put_req_header(conn, "if-none-match", tag)
    end
  end

  defp etag_for(response) do
    result = response.resp_headers
    |> Enum.filter(fn {key, _val} -> key == "etag" end)

    case result do
      [{"etag", key}] -> key
      _ -> nil
    end
  end
end
