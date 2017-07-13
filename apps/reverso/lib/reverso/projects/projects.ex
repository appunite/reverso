defmodule Reverso.Projects do

  import Ecto.Query, warn: false
  alias Reverso.Repo

  alias Reverso.Projects.Language
  alias Reverso.Projects.Translation
  alias Reverso.Projects.Project

  def list_languages do
    Repo.all(Language)
  end

  def get_language!(id), do: Repo.get!(Language, id)

  def create_language(attrs \\ %{}) do
    %Language{}
    |> Language.changeset(attrs)
    |> Repo.insert()
  end

  def update_language(%Language{} = language, attrs) do
    language
    |> Language.changeset(attrs)
    |> Repo.update()
  end

  def delete_language(%Language{} = language) do
    Repo.delete(language)
  end

  def change_language(%Language{} = language) do
    Language.changeset(language, %{})
  end

  def list_projects do
    Repo.all(Project)
  end

  def get_project!(id), do: Repo.get!(Project, id)

  def create_project(attrs \\ %{}) do
    %Project{}
    |> Project.changeset(attrs)
    |> Repo.insert()
  end

  def update_project(%Project{} = project, attrs) do
    project
    |> Project.changeset(attrs)
    |> Repo.update()
  end

  def delete_project(%Project{} = project) do
    Repo.delete(project)
  end

  def change_project(%Project{} = project) do
    Project.changeset(project, %{})
  end

  def list_translations do
    Repo.all(Translation)
  end

  def get_translation!(id), do: Repo.get!(Translation, id)

  def create_translation(attrs \\ %{}) do
    %Translation{}
    |> Translation.changeset(attrs)
    |> Repo.insert()
  end

  def update_translation(%Translation{} = translation, attrs) do
    translation
    |> Translation.changeset(attrs)
    |> Repo.update()
  end

  def delete_translation(%Translation{} = translation) do
    Repo.delete(translation)
  end

  def change_translation(%Translation{} = translation) do
    Translation.changeset(translation, %{})
  end
end
