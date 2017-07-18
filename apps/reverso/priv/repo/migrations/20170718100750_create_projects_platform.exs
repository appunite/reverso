defmodule Reverso.Repo.Migrations.CreateReverso.Projects.Platform do
  use Ecto.Migration

  def change do
    create table(:projects_platforms) do
      add :platform_name, :string
      add :project_id, references(:projects_projects)
      timestamps()
    end

  end
end
