defmodule LogstoreWeb.SessionController do
  use LogstoreWeb, :controller

  # alias LogstoreData.Schema
  alias LogstoreData.Api

  def new(conn, _) do
    render(conn, "new.html")
  end

  def create(conn, %{"session" => %{"email" => email, "pwd" => pwd}}) do
    case Api.User.user_auth_by_email_and_pwd(email, pwd) do
      {:ok, user} ->
        conn
        |> LogstoreWeb.Auth.login(user)
        |> put_flash(:info, "Welcome back!")
        |> redirect(to: Routes.home_path(conn, :index))

      {:error, _reason} ->
        conn
        |> put_flash(:error, "Invalid username/password combination")
        |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> LogstoreWeb.Auth.logout()
    |> redirect(to: Routes.home_path(conn, :index))
  end
end
