defmodule Reverso.Repo.Migrations.CreateReverso.Projects.Translation do
  use Ecto.Migration

  def change do
    create table(:projects_translations) do
      add :basic, :string
      add :translation, :string
      add :platform_key, :string

      add :platform_id, references(:projects_platforms)
      add :user_id, references(:accounts_users)
      add :project_id, references(:projects_projects)
      
      timestamps()
    end

  end
end
