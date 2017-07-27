defmodule Reverso.Accounts.Login do

  import Ecto.Query, warn: false
  alias Reverso.Repo
  alias Reverso.Accounts
  alias Reverso.Accounts.Authentication
  alias Reverso.Accounts.User
  alias Reverso.Accounts.Activation

  def create_login_token(%User{} = user) do
    user
    |> User.user_token_changeset(%{user_token: Ecto.UUID.generate()})
    |> Repo.update()
  end

  def delete_login_token(%User{} = user) do
    user
    |> User.user_token_changeset(%{user_token: nil})
    |> Repo.update()
  end

  def login(%{"email" => user_email, "password" => user_password}) do
    with {:ok, %User{} = user} <- Accounts.fetch_by_email(user_email),
         {:ok, _} <- Authentication.authenticate(user, user_password),
         {:ok, _} <- Activation.activated?(user),
         {:ok, user_with_token} <- create_login_token(user) do
      {:ok, user_with_token}
    else
      {:error, :user_not_found} -> {:error, :invalid_credentials}
      {:error, :auth_error} -> {:error, :invalid_credentials}
      {:error, :user_not_activated} -> {:error, :user_not_activated}
    end
  end
end
