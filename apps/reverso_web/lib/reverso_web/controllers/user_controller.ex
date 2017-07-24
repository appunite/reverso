defmodule Reverso.Web.UserController do
  use Reverso.Web, :controller

  alias Reverso.Accounts

  action_fallback TestJson.Web.FallbackController

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, %User{} = user} <- Accounts.fetch_by_id(id) do
      render(conn, "show.json", user: user)
    else
      _ -> send_resp(conn, 404, "User does not exist!")
    end
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.fetch_by_id(id),
         {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, user} <- Accounts.fetch_by_id(id),
         {:ok, _} <- Accounts.delete_user(user) do
      send_resp(conn,200, "")
    else
      _ -> send_resp(conn, 404, "User does not exist!")
    end
  end
end
