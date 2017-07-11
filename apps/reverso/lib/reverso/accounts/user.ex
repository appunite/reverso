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
    |> put_change(:crypted_password, hashed_password(user.password))
    
  end

  def login_changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :password])
    |> validate_required([:email, :password])
    |> validate_format(:email, ~r/@/)
  end
  
  defp hashed_password(password) do
    Comeonin.Bcrypt.hashpwsalt(password)
  end
end

