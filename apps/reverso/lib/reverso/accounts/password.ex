defmodule Reverso.Accounts.Password do

  import Ecto.Query, warn: false
  alias Reverso.Repo
  alias Reverso.Accounts
  alias Reverso.Accounts.User
  alias Reverso.Accounts.Authentication

  def change_password(%{
    "id" => id,
    "old_password" => old_password,
    "new_password_set" => new_password_set}) do
    with {:ok, %User{} = user} <- Accounts.fetch_by_id(id),
         {:ok, _} <- Authentication.authenticate(user, old_password) do
          user
          |> User.reset_password_changeset(new_password_set)
          |> Repo.update()
    else
      {:error, :user_not_found}-> {:error, :user_not_found}
      {:error, :auth_error} -> {:error, :auth_error}
      {:error, _} -> {:error, }
    end
  end

  def start_password_reset(%{"email" => email}) do
    with {:ok, %User{} = user} <- Accounts.fetch_by_email(email),
         {:ok, %User{} = user} <- create_password_token(user),
         {:ok, _} <- Reverso.Email.send_reset_password_email(user) do
      {:ok, :password_reset_started}
    else
      {:error, _} -> {:error, :user_not_found}
    end
  end

  def reset_password(%{
    "token" => token,
    "new_password" => new_password,
    "new_password_confirmation" => new_password_confirmation}) do
    with {:ok, %User{} = user} <- Accounts.fetch_by_password_token(token) do
      user
      |> User.reset_password_changeset(%{
        password: new_password,
        password_confirmation: new_password_confirmation})
      |> Repo.update()
    else
      {:error, :user_not_found} -> {:error, :invalid_credentials}
    end
  end

  def create_password_token(%User{} = user) do
    password_reset_token = Ecto.UUID.generate()
    Reverso.TokenRemover.add_token(password_reset_token)
    user
    |> User.user_token_changeset(%{password_reset_token: password_reset_token})
    |> Repo.update()
  end

  def delete_password_token(token) do
    with {:ok, %User{} = user} <- Accounts.fetch_by_password_token(token) do
      user
      |> User.user_token_changeset(%{password_reset_token: nil})
      |> Repo.update()
    end
  end
end
