defmodule Reverso.Repo.Migrations.DescriptionForProject do
  use Ecto.Migration

  def change do
    alter table(:projects_translations) do
      add :description, :string
    end 
  end
end
