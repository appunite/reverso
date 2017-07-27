defmodule Reverso.Repo.Migrations.DefualtTimeForProjectcontributor do
  use Ecto.Migration

  def change do
    alter table(:collaborators) do
      modify :inserted_at, :naive_datetime, default: fragment("now()")
      modify :updated_at, :naive_datetime, default: fragment("now()")
    end 
  end
end
