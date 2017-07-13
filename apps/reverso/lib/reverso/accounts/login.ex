defmodule Reverso.Accounts.Login do
  use Ecto.Schema
  import Ecto.Changeset
  alias Reverso.Accounts.Login


  schema "accounts_users" do
    field :email, :string
    field :crypted_password, :string
    field :password, :string, virtual: true, default: ""

    timestamps()
  end

@doc false
  def changeset(%Login{} = login, attrs) do
    login
    |> cast(attrs, [:email, :password])
    |> validate_required([:email, :password])
    |> validate_format(:email, ~r/@/)
  end
end

