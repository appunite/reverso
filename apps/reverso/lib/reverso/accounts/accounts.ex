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
    user_email
    |> fetch_by_email
    |> authenticate(user_password)
    |> activated?
    |> login_token
  end

  def login_token(params) do
    case params do
      {:ok, %User{} = user} ->
        create_login_token(user)
      {:error, _} ->
        params
    end
  end

  def activated?({:ok, %User{} = user}) do
    if user.activated do
      {:ok, user}
    else
      {:error, :user_not_activated}
    end
  end

  def activated?(params) do
    params
  end

  def authenticate(user, password) do
    case user do
      nil ->
        Comeonin.Bcrypt.dummy_checkpw()
        {:error, :invalid_credentials}
      _ ->
        if Comeonin.Bcrypt.checkpw(password, user.crypted_password) do
          {:ok, user}
        else
          {:error, :invalid_credentials}
        end
    end
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
