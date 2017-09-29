defmodule Reverso.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Reverso.Accounts.User


  schema "accounts_users" do
    field :email, :string, unique: true
    field :crypted_password, :string
    field :password, :string, virtual: true, default: ""
    field :password_confirmation, :string, virtual: true, default: ""
    field :name, :string
    field :user_token, :string, default: nil
    field :activated, :boolean, default: false
    field :activation_token, :string, default: nil
    field :password_reset_token, :string, default: nil
    field :invitation_token, :string, default: nil

    timestamps()
  end

  def changeset(%User{} = user, attrs \\ %{}) do
    user
    |> cast(attrs, [:email, :name, :password, :activation_token])
    |> validate_required([:email, :name, :password, :activation_token])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
    |> validate_length(:password, min: 5)
    |> validate_confirmation(:password)
    |> hash_password()
  end

  def new_invitation_changeset(%User{} = user, attrs \\ %{}) do
    user
    |> cast(attrs, [:email, :invitation_token])
    |> validate_required([:email, :invitation_token])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
  end

  def invitation_update_changeset(%User{} = user, attrs \\ %{}) do
    user
    |> cast(attrs, [:name, :password, :activation_token])
    |> validate_required([:name, :password, :activation_token])
    |> validate_length(:password, min: 5)
    |> validate_confirmation(:password)
    |> unique_constraint(:email)
    |> hash_password()

  end

  def update_changeset(%User{} = user, attrs \\ %{}) do
    user
    |> cast(attrs, [:email, :name])
    |> validate_required([:email, :name])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
  end

  def user_token_changeset(%User{} = user, attrs \\ %{}) do
    user
    |> cast(attrs, [:user_token, :activation_token, :password_reset_token])
  end

  def activate_changeset(%User{} = user) do
    user
    |> change()
    |> put_change(:activated, true)
    |> put_change(:activation_token, nil)
  end

  def reset_password_changeset(%User{} = user, attrs \\ %{}) do
    user
    |> cast(attrs, [:password])
    |> put_change(:password_reset_token, nil)
    |> validate_required([:password])
    |> validate_length(:password, min: 5)
    |> validate_confirmation(:password)
    |> hash_password()
  end

  defp hash_password(changeset) do
    password = get_change(changeset, :password)
    put_change(changeset, :crypted_password, hashed_password(password))
  end

  defp hashed_password(password) when password == "" or is_nil(password), do: nil
  defp hashed_password(password) do
    Comeonin.Bcrypt.hashpwsalt(password)
  end
end
