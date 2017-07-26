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
    plug AuthUser

  end

  scope "/", Reverso.Web do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/api", Reverso.Web do
    pipe_through :api_no_auth

    post "/login", SessionController, :create
    post "/accounts", UserController, :create
    get "/activate", TokenController, :activate_account
    post "/lostpassword", TokenController, :start_password_reset
    post "/resetpassword", TokenController, :password_reset
  end

  scope "/api", Reverso.Web do
    pipe_through :api_user_auth

    delete "/logout", SessionController, :delete
    resources "/accounts", UserController, except: [:create]
    resources "/projects", ProjectController
    get "/projects/:id/languages", LanguageController, :list
    resources "/translations", TranslationController
    resources "/languages", LanguageController
    get "/projects/:project_id/languages/:language_id", TranslationController, :index
  end

  if Mix.env == :dev do
    forward "/sent_emails", Bamboo.EmailPreviewPlug
  end
end
