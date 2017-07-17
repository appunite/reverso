defmodule Reverso.Web.Router do
  use Reverso.Web, :router

  alias Reverso.Web.Plugs.AuthUser

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api_no_auth do
    plug :accepts, ["json"]
  end

  pipeline :api_user_auth do
    plug :accepts, ["json"]
   # plug AuthUser
  end

  scope "/", Reverso.Web do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/api", Reverso.Web do
    pipe_through :api_no_auth

    get "/login", SessionController, :new
    post "/login", SessionController, :create
    #delete "/logout" SessionController, :delete
  end

  scope "/api", Reverso.Web do
    pipe_through :api_user_auth
    
    resources "/accounts", UserController
    resources "/projects", ProjectController
    resources "/translations", TranslationController
    resources "/languages", LanguageController
  end

  # Other scopes may use custom stacks.
  # scope "/api", Reverso.Web do
  #   pipe_through :api
  # end
end
