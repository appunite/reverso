defmodule Reverso.Web.SessionController do
  use Reverso.Web, :controller

  alias Reverso.Accounts
  alias Reverso.Accounts.Login
  alias Reverso.Accounts.User

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => session_params}) do
    with {:ok, %User{} = user } <- Accounts.login(session_params) do
      {:ok, user} ->
        conn
        |> put_resp_header("authorization", #...)
      :error ->
        conn
        #...
    end
  end
  #action_fallback TestJson.Web.FallbackController


  #def index(conn, _params) do
  #  users = Accounts.list_users()
  #  render(conn, "index.json", users: users)
  #end

  #def login(conn, %{"login" => login_params}) do
  #  with {:ok, %User{} = user} <- Accounts.login_user(login_params) do
  #    conn
  #    |> put_status(:logged_in)
  #    |> put_resp_header("location", user_path(conn, :show, user))
  #    |> render("show.json", user: user)
  #  end
  #end
end