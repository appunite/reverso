defmodule Reverso.Web.UserController do
  use Reverso.Web, :controller

  alias Reverso.Accounts
  alias Reverso.Accounts.User

  action_fallback TestJson.Web.FallbackController

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params),
         {:ok, _} <- Reverso.Email.send_activation_email(user) do
      conn
      |> put_status(200)
      |> render("show.json", %{user: user})
    else
      _->
        conn
        |> put_status(422)
        |> render("message.json", %{error: "Invalid credentials!"})
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, %User{} = user} <- Accounts.fetch_by_id(id) do
      render(conn, "show.json", user: user)
    else
    _ ->
        conn
        |> put_status(422)
        |> render("message.json", %{error: "User does not exist!"})
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
      _ ->
        conn
        |> put_status(422)
        |> render("message.json", %{error: "User does not exist!"})
    end
  end

  def change_password(conn, %{ "id" => id,
                               "old_password" => old_password,
                               "new_password_set" => new_password_set}) do
    with {:ok, %User{} = user} <- Accounts.fetch_by_id(id),
         {:ok, _} <- Accounts.authenticate(user, old_password),
         {:ok, _} <- Accounts.change_password(user, new_password_set) do
      conn
      |> send_resp(200, "")
    else
      {:error, :user_not_found} ->
        conn
        |> put_status(422)
        |> render("message.json", %{error: "Invalid credentials!"})
      {:error, :auth_error} ->
        conn
        |> put_status(422)
        |> render("message.json", %{error: "Invalid credentials!"})
      {:error, _} ->
        conn
        |> put_status(422)
        |> render("message.json", %{error: "Password and confirmation must match!"})
    end
  end
end
