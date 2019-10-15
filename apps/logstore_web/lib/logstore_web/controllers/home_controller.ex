defmodule LogstoreWeb.HomeController do
  use LogstoreWeb, :controller

  plug :authenticate when action in [:sites, :logs, :users]

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def urls(conn, _params) do
    render(conn, "urls.html")
  end

  def logs(conn, _params) do
    render(conn, "logs.html")
  end

  def sites(conn, _params) do
    render(conn, "sites.html")
  end

  def views(conn, _params) do
    render(conn, "views.html")
  end

  def setup(conn, _params) do
    render(conn, "setup.html")
  end

  def data(conn, _params) do
    render(conn, "data.html")
  end
  
  def subs(conn, _params) do
    conn
    # |> assign(:subs, Subs.show(userid(conn)))
    |> render("subs.html")
  end

  def signup(conn, _params) do
    render(conn, "signup.html")
  end

  # ----- 

  defp authenticate(conn, _opts) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in to access that page")
      |> redirect(to: Routes.home_path(conn, :index))
      |> halt()
    end
  end

  # defp userid(conn) do
  #   conn.assigns.current_user.id
  # end
end
