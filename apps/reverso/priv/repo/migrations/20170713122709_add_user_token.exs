defmodule Reverso.Repo.Migrations.AddUserToken do
  use Ecto.Migration

  def change do
    alter table(:accounts_users) do
      add :user_token, :string
      add :activated, :boolean
      add :activation_token, :string
      add :pw_reset_token, :string
    end
  end
end
