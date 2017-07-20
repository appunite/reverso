defmodule Reverso.Repo.Migrations.CreateReverso.Projects.Project do
  use Ecto.Migration

  def change do
    create table(:projects_projects) do
      add :project_name, :string
      add :basic_language, :string
      add :owner_id, references(:accounts_users)

      timestamps()
    end

  end
end
