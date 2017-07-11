defmodule Reverso.Repo.Migrations.CreateReverso.Accounts.User do
  use Ecto.Migration

  def change do
    create table(:accounts_users) do
      add :email, :string
      add :username, :string
      add :password, :string

      timestamps()
    end

  end
end
