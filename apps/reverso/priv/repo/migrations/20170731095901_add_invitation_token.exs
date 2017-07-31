defmodule Reverso.Repo.Migrations.AddInvitationToken do
  use Ecto.Migration

  def change do
    alter table(:accounts_users) do
      add :invitation_token, :string
    end
  end
end
