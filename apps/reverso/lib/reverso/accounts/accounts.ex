defmodule Reverso.Accounts do
  @moduledoc """
  The boundary for the Accounts system.
  """

  import Ecto.Query, warn: false
  alias Reverso.Repo

  alias Reverso.Accounts.User


  def list_users do
    Repo.all(User)
  end

  def create_user(attrs) do
    %User{}
    |> User.changeset(Map.put(attrs, :activation_token, Ecto.UUID.generate()))
    |> Repo.insert()
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.update_changeset(attrs)
    |> Repo.update()
  end

  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  def fetch_by_id(id) do
    with %User{} = user <- Repo.get_by(User,id: id) do
      {:ok, user}
    else
      _ -> {:error, :user_not_found}
    end
  end

  def fetch_by_token(token) do
    with %User{} = user <- Repo.get_by(User,user_token: token) do
      {:ok, user}
    else
      _ -> {:error, :user_not_found}
    end
  end

  def fetch_by_email(email)do
    with %User{} = user <- Repo.get_by(User,email: email) do
      {:ok, user}
    else
      _ -> {:error, :user_not_found}
    end
  end

  def create_login_token(%User{} = user) do
    user
    |> User.user_token_changeset(%{user_token: Ecto.UUID.generate()})
    |> Repo.update()
  end

  def create_activation_token(%User{} = user) do
    user
    |> User.user_token_changeset(%{activation_token: Ecto.UUID.generate()})
    |> Repo.update()
  end

  def create_password_token(%User{} = user) do
    user
    |> User.user_token_changeset(%{password_reset_token: Ecto.UUID.generate()})
    |> Repo.update()
  end

  def delete_login_token(%User{} = user) do
    user
    |> User.user_token_changeset(%{user_token: nil})
    |> Repo.update()
  end

  def delete_activation_token(%User{} = user) do
    user
    |> User.user_token_changeset(%{activation_token: nil})
    |> Repo.update()
  end

  def delete_password_token(%User{} = user) do
    user
    |> User.user_token_changeset(%{password_reset_token: nil})
    |> Repo.update()
  end

  def login(%{"email" => user_email, "password" => user_password}) do
    with {:ok, %User{} = user} <- fetch_by_email(user_email),
         {:ok, _} <- authenticate(user, user_password),
         {:ok, _} <- activated?(user),
         {:ok, user_with_token} <- create_login_token(user) do
      {:ok, user_with_token}
    else
      {:error, :invalid_credentials} -> {:error, :invalid_credentials}
      {:error, :auth_error} -> {:error, :invalid_credentials}
      {:error, :user_not_activated} -> {:error, :user_not_activated}
    end
  end

  def activated?(%User{activated: true}) do {:ok, :user_activated} end
  def activated?(_) do {:error, :user_not_activated} end

  def authenticate(%User{} = user, password) do
    case Comeonin.Bcrypt.checkpw(password, user.crypted_password) do
      true -> {:ok, :auth_ok}
      _ -> {:error, :auth_error}
    end
  end

  def authenticate(_, _) do
    Comeonin.Bcrypt.dummy_checkpw()
    {:error, :auth_error}
  end

  def reset_password(token, new_password) do
    case Repo.get_by(User, password_reset_token: token) do
      %User{} = user ->
        user
        |> User.reset_password_changeset(%{password: new_password, password_reset_token: nil})
        |> Repo.update()
      _ ->
        {:error, :user_not_found}
    end
  end

  def activate(token) do
    case Repo.get_by(User, activation_token: token) do
      %User{} = user ->
        User.activate_changeset(user)
        |> Repo.update()
      _ ->
        {:error, :user_not_found} 
    end
  end
end
