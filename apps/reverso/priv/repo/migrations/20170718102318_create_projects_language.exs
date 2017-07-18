defmodule Reverso.Repo.Migrations.CreateReverso.Projects.Language do
  use Ecto.Migration

  def change do
    create table(:projects_languages) do
      add :language_name, :string
      add :project_id, references(:projects_projects)
      timestamps()
    end

    alter table(:projects_translations) do
      add :language_id, references(:projects_languages)
    end

  end
end
