defmodule Reverso.Repo.Migrations.AddDateDefaultTime do
  use Ecto.Migration

  def change do
    alter table(:projects_projects) do
      modify :inserted_at, :naive_datetime, default: fragment("now()")
      modify :updated_at, :naive_datetime, default: fragment("now()")
    end 
    alter table(:projects_translations) do
      modify :inserted_at, :naive_datetime, default: fragment("now()")
      modify :updated_at, :naive_datetime, default: fragment("now()")
    end
    alter table(:projects_languages) do
      modify :inserted_at, :naive_datetime, default: fragment("now()")
      modify :updated_at, :naive_datetime, default: fragment("now()")
    end
    alter table(:projects_platforms) do
      modify :inserted_at, :naive_datetime, default: fragment("now()")
      modify :updated_at, :naive_datetime, default: fragment("now()")
    end
  end
end
