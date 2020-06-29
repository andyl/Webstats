defmodule BadgerWeb.SessionController do
  use BadgerWeb, :controller

  # alias BadgerData.Schema
  alias BadgerData.Api

  def new(conn, _) do
    render(conn, "new.html")
  end

  def create(conn, %{"session" => %{"email" => email, "pwd" => pwd}}) do
    case Api.User.user_auth_by_email_and_pwd(email, pwd) do
      {:ok, user} ->
        conn
        |> BadgerWeb.Plug.Auth.login(user)
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
    |> BadgerWeb.Plug.Auth.logout()
    |> redirect(to: Routes.home_path(conn, :index))
  end
end
