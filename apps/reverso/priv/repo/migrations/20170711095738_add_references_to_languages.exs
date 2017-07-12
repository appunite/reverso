defmodule Reverso.Repo.Migrations.AddReferencesToLanguages do
  use Ecto.Migration

  def change do
    alter table(:projects_languages) do
     # add :language, :string
      add :project_id, references(:projects_projects)


      #timestamps()
    end
  end
  

end
