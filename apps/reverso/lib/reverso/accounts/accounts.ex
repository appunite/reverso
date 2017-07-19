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

  def login(%{"email" => user_email, "password" => user_password} \\ %{}) do
    user = Repo.get_by(User,email: user_email)
      case authenticate(user,user_password) do
        true ->
          case user.activated do
            true ->
              {:ok, user_with_token} = create_login_token(user)
              {:ok, user_with_token}
            _    ->
              {:error, :user_not_activated}
          end
        _    -> {:error, :invalid_credentials}
      end
  end

  def authenticate(user, password) do
    case user do
      nil ->
        Comeonin.Bcrypt.dummy_checkpw()
        false
      _ -> Comeonin.Bcrypt.checkpw(password, user.crypted_password)
    end
  end

  def reset_password(token, new_password) do
    case Repo.get_by(User, password_reset_token: token) do
      %User{} = user ->
        user
        |> User.reset_password_changeset(%{password: new_password, password_reset_token: nil})
        |> Repo.update()
      _ ->
        {:user_not_found, "User with specified token not found!"}
    end
  end

  def activate(token) do
    case Repo.get_by(User, activation_token: token) do
      %User{} = user ->
        User.activate_changeset(user)
        |> Repo.update()
      _ ->
        {:user_not_found, "User with specified token not found!"}
    end
  end

  def generate_activation_url(%User{} = user) do
    ["localhost:4000/api/activate/?token=", user.activation_token]
    |> Enum.join
  end

  def generate_password_reset_url(%User{} = user) do
    ["localhost:4000/api/resetpassword/?token=", user.password_reset_token]
    |> Enum.join
  end

  def send_message(mail) do

  end
end
