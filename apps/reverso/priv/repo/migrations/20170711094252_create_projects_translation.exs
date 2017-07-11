defmodule Reverso.Repo.Migrations.CreateReverso.Projects.Translation do
  use Ecto.Migration

  def change do
    create table(:projects_translations) do
      add :basic, :string
      add :translation, :string
      #add :project_id, references(:projects_projects)
      #add :language_id, references(:projects_languages)
      timestamps()
    end

  end
end
