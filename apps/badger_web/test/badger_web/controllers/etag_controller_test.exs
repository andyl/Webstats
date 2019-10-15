defmodule BadgerWeb.EtagControllerTest do
  use BadgerWeb.ConnCase
  use BadgerData.DataCase

  alias BadgerData.Schema

  setup do
    Repo.delete_all(Schema.View)
    Repo.delete_all(Schema.Token)
    :ok
  end

  # basic response
  test "GET /png0/1", %{conn: conn} do
    conn = get(conn, "/png0/#{siteid()}?path=/a/b/c")
    assert response(conn, 200)
  end

  # one query - check for database objects
  test "GET /png0/2", %{conn: conn} do
    assert count(Schema.View) == 0
    assert count(Schema.Token) == 0
    conn = get(conn, "/png0/#{siteid()}")
    assert response(conn, 200) 
    assert count(Schema.View) == 1
    assert count(Schema.Token) == 1
  end

  # two queries - check for multiple database objects
  test "GET /png0/3", %{conn: conn} do
    assert count(Schema.Token) == 0
    assert count(Schema.View) == 0
    id = siteid()
    get(conn, "/png0/#{id}")
    get(conn, "/png0/#{id}")
    assert count(Schema.Token) == 2
    assert count(Schema.View) == 2
  end

  # two queries with etag - check for reuse of Token
  test "GET /png0/4", %{conn: conn} do
    assert count(Schema.Token) == 0
    assert count(Schema.View) == 0
    id = siteid()
    resp = get(conn, "/png0/#{id}")
    altconn(conn, resp) |> get("/png0/#{id}")
    assert count(Schema.Token) == 1
    assert count(Schema.View) == 2
  end

  # ---------------------------------------------------------

  defp siteid do
    BadgerData.Api.Site.apphost_id() 
  end

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
