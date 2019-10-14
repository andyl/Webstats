defmodule LogstoreWeb.Router do
  use LogstoreWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Phoenix.LiveView.Flash
    plug LogstoreWeb.Auth

  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", LogstoreWeb do
    pipe_through :browser

    get "/",     HomeController, :index
    get "/urls", HomeController, :urls
    get "/logs", HomeController, :logs
    get "/data", HomeController, :data

    get  "/login",  HomeController,  :login
    get  "/signup", HomeController,  :signup

    resources "/users", UserController, only: [:index, :show, :new, :create]
    resources "/sessions", SessionController, only: [:new, :create, :delete]

    get "/png0/:site_id", EtagController, :png0
    get "/gif0/:site_id", EtagController, :gif0
    get "/jpg0/:site_id", EtagController, :jpg0
    get "/pngF/:site_id", EtagController, :pngF
    get "/gifF/:site_id", EtagController, :gifF
    get "/jpgF/:site_id", EtagController, :jpgF

    live "/demo", Demo
  end

  scope "/api", LogstoreWeb do
    pipe_through :api
  end
end
