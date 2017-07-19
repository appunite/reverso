defmodule Reverso.Repo.Migrations.CreateReverso.Accounts.User do
  use Ecto.Migration

  def change do
    create table(:accounts_users) do
      add :email, :string
      add :name, :string
      add :crypted_password, :string

      timestamps()
    end

    create unique_index(:accounts_users, [:email])

  end
end s
