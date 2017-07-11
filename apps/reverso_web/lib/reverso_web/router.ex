defmodule Reverso.Web.Router do
  use Reverso.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Reverso.Web do
    pipe_through :browser # Use the default browser stack

    resources "/users", UserController
    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", Reverso.Web do
  #   pipe_through :api
  # end
end
