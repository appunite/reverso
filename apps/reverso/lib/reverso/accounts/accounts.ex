defmodule Reverso.Accounts do
  @moduledoc """
  The boundary for the Accounts system.
  """

  import Ecto.Query, warn: false
  alias Reverso.Repo
  import Ecto.Changeset

  alias Reverso.Accounts.User


  def list_users do
    Repo.all(User)
  end

  def get_user!(email), do: Repo.get!(User, email)

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
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

  def login_user(%User{} = user, attrs) do
    user
    |> User.login_changeset(attrs)
  end
end
