defmodule BadgerWeb.Router do
  use BadgerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Phoenix.LiveView.Flash
    plug BadgerWeb.Auth
    plug BadgerWeb.SiteTag
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BadgerWeb do
    pipe_through :browser

    get "/",      HomeController, :index
    get "/urls",  HomeController, :urls
    get "/logs",  HomeController, :logs
    get "/sites", HomeController, :sites
    get "/views", HomeController, :views
    get "/data",  HomeController, :data
    get "/setup", HomeController, :setup

    get  "/login",  HomeController,  :login
    get  "/signup", HomeController,  :signup

    resources "/users", UserController, only: [:index, :show, :new, :create]
    resources "/sessions", SessionController, only: [:new, :create, :delete]

    get "/png0/:req_tag", EtagController, :png0
    get "/gif0/:req_tag", EtagController, :gif0
    get "/jpg0/:req_tag", EtagController, :jpg0
    get "/pngF/:req_tag", EtagController, :pngF
    get "/gifF/:req_tag", EtagController, :gifF
    get "/jpgF/:req_tag", EtagController, :jpgF

    live "/demo", Demo
  end

  scope "/api", BadgerWeb do
    pipe_through :api
  end
end
