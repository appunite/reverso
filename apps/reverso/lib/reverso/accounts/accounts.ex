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

  def get_user!(id), do: Repo.get!(User, id)

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(Map.put(attrs, :activation_token, Ecto.UUID.generate()))
    |> Repo.insert()
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  def fetch_by_token(token) do
    Repo.get_by!(User, token)
  end

  def fetch_by_email(email)do
    Repo.get_by(User,email: email)
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
    with {:ok, %User = user} <- fetch_by_email(user_email),
         {:ok, _} <- authenticate(user, user_password),
         {:ok, _} <- activated?(user) do
      {:ok, user}
    else
      {:error, nil} -> {:error, :invalid_credentials}
      {:error, :auth_error} -> {:error, :invalid_credentials}
      {:error, :user_not_activated} -> {:error, :user_not_activated}
    end
  end

  def activated?(%User{} = user) do
    case user.activated do
      true -> {:ok, :user_activated}
      false -> {:error, :user_not_activated}
    end
  end

  def authenticate(%User = user, password) do
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
