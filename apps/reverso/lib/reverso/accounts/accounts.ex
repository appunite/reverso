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

  def fetch_by_token(token) do
    Repo.get_by!(User, token)
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

  def create_pw_token(%User{} = user) do
    user
    |> User.user_token_changeset(%{pw_reset_token: Ecto.UUID.generate()})
    |> Repo.update()
  end

  def delete_login_token(%User{} = user) do
    user
    |> User.user_token_changeset(%{user_token: nil})
    |> Repo.update()
  end

  def login(attrs \\ %{}) do
    user = Repo.get_by!(User,email: attrs["email"])
    case authenticate(user,attrs["password"]) do
      true -> {:ok, user}
      _    -> :error
    end
  end

  def authenticate(user, password) do
    IO.inspect(user)
    case user do
      nil -> 
        Comeonin.Bcrypt.dummy_checkpw()
        false
      _   -> Comeonin.Bcrypt.checkpw(password, user.crypted_password)
    end
  end
end
