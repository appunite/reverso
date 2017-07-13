defmodule Reverso.Repo.Migrations.ProjectRefactor do
  use Ecto.Migration

  def change do
    alter table(:projects_projects) do
      add :code, :integer
    end

    alter table(:projects_translations) do
      add :android_key, :string
      add :ios_key, :string
      add :pc_key, :string
    end

  end
end
