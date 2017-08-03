defmodule Reverso.Repo.Migrations.DatabaseRefactor do
  use Ecto.Migration

  def change do
    drop table(:projects_translations)

    create table(:terms) do
      add :text, :string
      add :user_id, references(:accounts_users)
      add :language_id, references(:projects_languages, on_delete: :delete_all)
      add :translation_id, :string
      
      timestamps()
    end

    alter table(:projects_projects) do
      add :basic_language_id, references(:projects_languages)
    end

    create table(:term_platform) do
      add :platform_id, references(:projects_platforms, on_delete: :delete_all)
      add :term_id, references(:terms, on_delete: :delete_all)
      add :platform_key, :string

      timestamps()
    end
  end
end
