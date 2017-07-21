defmodule Reverso.Web.UserController do
  use Reverso.Web, :controller

  alias Reverso.Accounts

  action_fallback TestJson.Web.FallbackController

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, _user} <- Accounts.create_user(user_params) do
      send_resp(conn, 200, "User created!")
    end
  end

  def update(conn, %{"user" => user_params}) do
    with  {:ok, _user} <- Accounts.update_user(conn.assigns[:current_user], user_params) do
      send_resp(conn, 200, "User updated!")
    else
      _ -> send_resp(conn, 404, "User does not exist!")
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, user} <- Accounts.fetch_by_id(id),
         {:ok, _} <- Accounts.delete_user(user) do
      send_resp(conn, 200, "User removed!")
    else
      {:error, :user_not_found} -> send_resp(conn, 404, "User does not exist!")
      _ -> send_resp(conn, 400, "Can't delete user!")
    end
  end
end
