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

  pipeline :manage_layout do
    plug :put_layout, {Reverso.Web.LayoutView, :logged_in}
  end

  scope "/manage", Reverso.Web do
    pipe_through [:browser, :manage_layout]

    resources "/projects", ProjectController
    resources "/translations", TranslationController
    resources "/langauges", LanguageController
  end  

  scope "/", Reverso.Web do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/users", UserController
    #resources "/projects", ProjectController
    #resources "/translations", TranslationController
    #resources "/langauges", LanguageController
  end

  # Other scopes may use custom stacks.
  # scope "/api", Reverso.Web do
  #   pipe_through :api
  # end
end
