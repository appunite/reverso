defmodule Reverso.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Reverso.Accounts.User


  schema "accounts_users" do
    field :email, :string, unique: true
    field :crypted_password, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
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
  end

  
end

