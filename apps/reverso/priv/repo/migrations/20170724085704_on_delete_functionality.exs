defmodule Reverso.Repo.Migrations.OnDeleteFunctionality do
  use Ecto.Migration

  def change do 
    execute "ALTER TABLE collaborators DROP CONSTRAINT collaborators_user_id_fkey"
    execute "ALTER TABLE collaborators DROP CONSTRAINT collaborators_project_id_fkey"
    execute "ALTER TABLE projects_platforms DROP CONSTRAINT projects_platforms_project_id_fkey"
    execute "ALTER TABLE projects_translations DROP CONSTRAINT projects_translations_project_id_fkey"
    execute "ALTER TABLE projects_translations DROP CONSTRAINT projects_translations_platform_id_fkey"
    execute "ALTER TABLE projects_translations DROP CONSTRAINT projects_translations_language_id_fkey"
    execute "ALTER TABLE projects_languages DROP CONSTRAINT projects_languages_project_id_fkey"
    
    alter table(:collaborators) do
      modify :user_id, references(:accounts_users, on_delete: :delete_all) 
      modify :project_id, references(:projects_projects, on_delete: :delete_all) 
    end

    alter table(:projects_platforms) do
      modify :project_id, references(:projects_projects, on_delete: :delete_all)
    end

    alter table(:projects_translations) do
      modify :platform_id, references(:projects_platforms, on_delete: :delete_all)
      modify :project_id, references(:projects_projects, on_delete: :delete_all)
      modify :language_id, references(:projects_languages, on_delete: :delete_all)
    end

    alter table(:projects_languages) do
      modify :project_id, references(:projects_projects, on_delete: :delete_all)
    end
  end
end
