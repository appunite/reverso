defmodule Reverso.Projects do

  import Ecto.Query, warn: false
  alias Reverso.Repo
  alias Ecto.Query
  alias Reverso.Projects
  alias Reverso.Projects.Project
  alias Reverso.Projects.Translation
  alias Reverso.Projects.Language
  alias Reverso.Projects.Platform
  alias Reverso.Accounts.ProjectCollaborator
  alias Reverso.Accounts.User
  import Ecto.DataType.NaiveDateTime

  def list_project(user_id) do
    query = Ecto.Query.from c in ProjectCollaborator,
    join: p in Project,
    on: p.id == c.project_id,
    where: c.user_id == ^user_id,
    select: %{id: p.id, project_name: p.project_name, basic_language: p.basic_language}
    sum = Repo.all(query)

    Enum.map(sum, fn s ->
      Map.put(s,:platforms,Projects.list_platform(s.id))
      |> Map.put(:languages,Projects.get_project_language_properties(s.id))
      end)
  end

  def create_project(attrs, platforms) do

   {:ok, project} =  %Project{}
    |> Project.changeset(attrs)
    |> Repo.insert()

    plat = Enum.map(platforms, fn p ->
      %{platform_name: p , project_id: project.id}
      end)
    Repo.insert_all(Platform,plat)

    Projects.associate_with_project(project.owner_id, project.id)
    {:ok, project}
  end
  
  def associate_with_project(user_id,project_id) do
     %ProjectCollaborator{}
     |> ProjectCollaborator.changeset(%{user_id: user_id, project_id: project_id})
     |> Repo.insert()
  end

  def delete_project(project_id) do
     project = Repo.get!(Project,project_id)
     Repo.delete(project) 
  end

  def delete_association_with_project(user_id,project_id) do
    Repo.get_by(ProjectCollaborator, project_id: project_id, user_id: user_id)
    |> Repo.delete()
  end

  def create_platform(attrs) do
    %Platform{}
    |> Platform.changeset(attrs)
    |> Repo.insert()
  end

  def list_platform(project_id) do
    query = Query.from pl in Platform,
    join: p in Project,
    on: pl.project_id == p.id,
    where: pl.project_id == ^project_id,
    select: pl.platform_name
    Repo.all(query)
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

  def list_languages do
    query = Ecto.Query.from l in Language,
    distinct: true,
    select: %{language_name: l.language_name}
    Repo.all(query)
  end

  def get_language!(id), do: Repo.get!(Language, id)

  def create_language(attrs) do
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

  def get_project_language_properties(project_id) do

    sub_query = 
    Ecto.Query.from l in Language,
    left_join: t in Translation,
    on: l.id == t.language_id,
    where: l.project_id == ^project_id,
    group_by: l.id,
    select: %{language_id: l.id, language_name: l.language_name, last_edit: max(t.updated_at), count: count(t.id), project_id: l.project_id}

    query = 
    Ecto.Query.from u in User,
    left_join: t in Translation,
    right_join: sb in subquery(sub_query),
    on: sb.last_edit == t.updated_at,
    on: u.id == t.user_id,
    select: %{language_id: sb.language_id, language_name: sb.language_name , editor: u.name, words_count: sb.count, project_id: sb.project_id, last_edit: sb.last_edit}
    sum = Repo.all(query)
    Enum.map(sum, fn s ->
      if(s.last_edit) do
        {{y,m,d},{h,min,sec,_}} = s.last_edit      
        {:ok ,date} = NaiveDateTime.from_erl({{y,m,d},{h,min,sec}})
        Map.put(s,:last_edit,date)
      else
        s
      end
    end)

  end

  def get_translation_for_project(project_id, language_id) do
    query = Ecto.Query.from u in Translation, 
    where: u.project_id == ^project_id and u.language_id == ^language_id,
    select: u
    Repo.all(query)
  end


end