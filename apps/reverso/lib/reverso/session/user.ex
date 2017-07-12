defmodule Reverso.Session.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Reverso.Session.User


  schema "accounts_users" do
    field :email, :string
    field :crypted_password, :string
    field :password, :string, virtual: true, default: ""

    timestamps()
  end

@doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :password])
    |> validate_required([:email, :password])
    |> validate_format(:email, ~r/@/)
  end
end

