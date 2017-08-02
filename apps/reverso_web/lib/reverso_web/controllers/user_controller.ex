defmodule Reverso.Web.UserController do
  use Reverso.Web, :controller

  alias Reverso.Accounts
  alias Reverso.Accounts.User
  alias Reverso.Accounts.Password

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

  def change_password(conn, new_password_set) do
    with {:ok, _} <- Password.change_password(new_password_set) do
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

  def resend_activation_email(conn, %{"email" => email}) do
    with {:ok, %User{} = user} <- Accounts.fetch_by_email(email),
         {:ok, _} <- Reverso.Email.send_activation_email(user) do
      conn
      |> send_resp(200, "")
    else
      {:error, _} ->
        conn
        |> send_resp(200, "")
    end
  end
end
