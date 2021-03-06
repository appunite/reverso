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

    post "/invitation/update", InvitationController, :update_user_from_invitation
    post "/login", SessionController, :create
    post "/accounts", UserController, :create
    get "/activate", AccountController, :activate_account
    post "/lostpassword", AccountController, :start_password_reset
    post "/resetpassword", AccountController, :password_reset
    post "/activate/resend", UserController, :resend_activation_email
  end

  scope "/api", Reverso.Web do
    pipe_through :api_user_auth

    post "/invitation/new", InvitationController, :create
    delete "/logout", SessionController, :delete
    resources "/accounts", UserController, except: [:create, :change_password]
    post "/changepassword", UserController, :change_password
    get "/collaborators", CollaboratorController, :index
    post "/collaborators", CollaboratorController, :create
    resources "/languages", LanguageController
    resources "/projects", ProjectController, only: [:index, :create, :update, :delete]
    get "/projects/:project_id/:language_id", ProjectController, :show
    get "/projects/:project_id/languages/:language_id/", TermController, :index
    post "/projects/:project_id/languages/:language_id", TermController, :create
    patch "/projects/:project_id/languages/:language_id/:translation_id", TermController, :update
    delete "/projects/:project_id/languages/:language_id/:translation_id", TermController, :delete
  end

  if Mix.env == :dev do
    forward "/sent_emails", Bamboo.EmailPreviewPlug
  end
end
