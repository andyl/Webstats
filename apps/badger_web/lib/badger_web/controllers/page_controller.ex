defmodule BadgerWeb.PageController do
  use BadgerWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
