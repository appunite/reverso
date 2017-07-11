defmodule Reverso.Repo.Migrations.CreateReverso.Projects.Project do
  use Ecto.Migration

  def change do
    create table(:projects_projects) do
      add :title, :string
      add :platform, :string

      timestamps()
    end

  end
end
