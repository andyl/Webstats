defmodule BadgerWeb.UserController do
  use BadgerWeb, :controller

  alias BadgerData.Schema
  alias BadgerData.Api

  plug :authenticate when action in [:index, :show]

  def index(conn, _params) do
    users = Api.User.user_list()
    render(conn, "index.html", users: users)
  end

  def show(conn, %{"id" => id}) do
    user = Api.User.user_get(id)
    render(conn, "show.html", user: user)
  end

  def new(conn, _params) do
    changeset = Api.User.user_changeset(%Schema.User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Api.User.user_signup(user_params) do
      {:ok, user} ->
        conn
        |> BadgerWeb.Auth.login(user)
        |> put_flash(:info, "#{user.name} created!")
        |> redirect(to: Routes.user_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

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
end
