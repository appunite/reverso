defmodule Reverso.Projects do

  import Ecto.Query, warn: false
  alias Reverso.Repo

  alias Reverso.Projects.Project
  alias Reverso.Accounts.ProjectCollaborator

  def list_project do
    Repo.all(Project)
  end

  def get_project!(id), do: Repo.get!(Project, id)

  def create_project(attrs \\ %{}) do
    %Project{}
    |> Project.changeset(attrs)
    |> Repo.insert()
  end
  
  def associate_with_project(user_id,project_id) do
     %ProjectCollaborator{}
     |> ProjectCollaborator.changeset(%{user_id: user_id, project_id: project_id})
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

  def delete_association_with_project(user_id,project_id) do
    Repo.get_by(ProjectCollaborator, project_id: project_id, user_id: user_id)
    |> Repo.delete()
  end

  def change_project(%Project{} = project) do
    Project.changeset(project, %{})
  end

  alias Reverso.Projects.Platform

  def list_platforms do
    Repo.all(Platform)
  end

  def get_platform!(id), do: Repo.get!(Platform, id)

  def create_platform(attrs \\ %{}) do
    %Platform{}
    |> Platform.changeset(attrs)
    |> Repo.insert()
  end

  def update_platform(%Platform{} = platform, attrs) do
    platform
    |> Platform.changeset(attrs)
    |> Repo.update()
  end

  def delete_platform(%Platform{} = platform) do
    Repo.delete(platform)
  end

  def change_platform(%Platform{} = platform) do
    Platform.changeset(platform, %{})
  end

  alias Reverso.Projects.Translation

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

  alias Reverso.Projects.Language

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

  def get_languages_by_project(project_id) do

    query = Ecto.Query.from u in "projects_languages",
    where: u.project_id == ^project_id,
    select: u.language_name
    Repo.all(query)

  end
end
