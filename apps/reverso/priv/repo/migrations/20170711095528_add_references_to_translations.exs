defmodule Reverso.Repo.Migrations.AddReferencesToTranslations do
  use Ecto.Migration

  def change do
    alter table(:projects_translations) do
      #add :basic, :string
      #add :translation, :string
      add :project_id, references(:projects_projects)
      add :language_id, references(:projects_languages)
    
    end
  end
end
