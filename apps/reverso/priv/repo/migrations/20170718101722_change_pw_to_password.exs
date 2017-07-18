defmodule Reverso.Repo.Migrations.ChangePwToPassword do
  use Ecto.Migration

  def change do
    rename table(:accounts_users), :pw_reset_token, to: :password_reset_token
  end
end
