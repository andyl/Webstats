defmodule LogstoreWeb.Router do
  use LogstoreWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Phoenix.LiveView.Flash
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
    get "/etag", EtagController, :index

    live "/demo", Demo
  end

  scope "/api", LogstoreWeb do
    pipe_through :api
  end
end
