defmodule Reverso.Repo.Migrations.AddCollaborators do
  use Ecto.Migration

  def change do
    create table (:collaborators) do
      add :user_id, references(:accounts_users)
      add :project_id, references(:projects_projects)
      timestamps()
    end

  end
end
