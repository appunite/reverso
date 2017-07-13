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
    field :user_token, :string, default: ""
    field :activated, :binary, default: false
    field :activation_token, :string, default: ""
    field :pw_reset_token, :string, default: ""

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :name, :password])
    |> validate_required([:email, :name, :password])
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 5)
    |> validate_confirmation(:password)
    |> unique_constraint(:email)
    |> hash_password()
  end

  def user_token_changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:user_token])
  end

  def activate_changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:activated, :activation_token])
  end

  defp hash_password(changeset) do
    password = get_change(changeset, :password)
    put_change(changeset, :crypted_password, hashed_password(password))
  end
  
  defp hashed_password(password) do
    Comeonin.Bcrypt.hashpwsalt(password)
  end
end

