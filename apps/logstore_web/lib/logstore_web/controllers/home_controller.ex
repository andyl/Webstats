defmodule LogstoreWeb.HomeController do
  use LogstoreWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def urls(conn, _params) do
    render(conn, "urls.html")
  end

  def logs(conn, _params) do
    render(conn, "logs.html")
  end

  def data(conn, _params) do
    render(conn, "data.html")
  end
end
