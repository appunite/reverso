defmodule Reverso.Repo.Migrations.CreateReverso.Projects.Language do
  use Ecto.Migration

  def change do
    create table(:projects_languages) do
      add :language, :string
      #add :project_id, references(:projects_projects)


      timestamps()
    end

  end
end
