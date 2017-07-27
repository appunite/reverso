defmodule Reverso.Accounts.Activation do

  import Ecto.Query, warn: false
  alias Reverso.Repo
  alias Reverso.Accounts.User

  def create_activation_token(%User{} = user) do
    user
    |> User.user_token_changeset(%{activation_token: Ecto.UUID.generate()})
    |> Repo.update()
  end

  def delete_activation_token(%User{} = user) do
    user
    |> User.user_token_changeset(%{activation_token: nil})
    |> Repo.update()
  end

  def activated?(%User{activated: true}) do {:ok, :user_activated} end
  def activated?(_) do {:error, :user_not_activated} end

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
