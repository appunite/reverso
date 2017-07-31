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
  import Reverso.SweetXml

  def fetch_projects(user_id) do
    editor_query =
      from(t in Translation,
        join: u in User, on: t.user_id == u.id,
        order_by: [desc: t.updated_at],
        select: u.name
      )

    languages_query =
      from(l in Language,
        left_join: t in Translation,
        on: t.language_id == l.id and t.project_id == l.project_id,
        left_join: u in User,
        on: t.user_id == u.id,
        group_by: l.id,
        select: %{l |
          strings_count: count(t.id),
          last_edit_time: max(t.updated_at)
        },
        preload: [last_editor_name: ^editor_query],
      )

    result = from(p in Project,
      join: c in ProjectCollaborator,
      join: pl in assoc(p, :platforms),
      on: c.project_id == p.id and c.user_id == ^user_id,
      where: pl.project_id == p.id,
      preload: [languages: ^languages_query],
      preload: [platforms: pl]
    )
    |> Repo.all()

    Enum.map(result, fn f -> 
      %{f | number_of_languages: length(f.languages)}      
      end)      
  end

  def fetch_project_info(project_id,language_id) do
    editor_query =
      from(t in Translation,
        join: u in User, on: t.user_id == u.id,
        order_by: [desc: t.updated_at],
        select: u.name
      )

    languages_query =
      from(l in Language,
        left_join: t in Translation,
        on: t.language_id == l.id and t.project_id == l.project_id,
        where: l.id == ^language_id,
        left_join: u in User,
        on: t.user_id == u.id,
        group_by: l.id,
        select: %{l |
          strings_count: count(t.id),
          last_edit_time: max(t.updated_at)
        },
        preload: [last_editor_name: ^editor_query]
      )

    from(p in Project,
      join: c in ProjectCollaborator, on: c.project_id == p.id,
      join: pl in assoc(p, :platforms), on: pl.project_id == p.id,
      where: p.id == ^project_id,
      preload: [languages: ^languages_query],
      preload: [platforms: pl]
    )
    |> Repo.one()
  end

  def create_project(attrs, platforms) do
   {:ok, project} =  %Project{}
    |> Project.changeset(attrs)
    |> Repo.insert()

    create_platforms_by_list(platforms,project.id)
    associate_project_owner(project.owner_id, project.id)
    platforms_after_changes = get_platform_by_project_id(project.id)

    {:ok, %{
      id: project.id,
      number_of_languages: 0,
      project_name: project.project_name,
      basic_language: project.basic_language,
      platforms: platforms_after_changes, languages: []}} 
  end
  
  def associate_project_owner(user_id,project_id) do
     %ProjectCollaborator{}
     |> ProjectCollaborator.changeset(%{user_id: user_id, project_id: project_id})
     |> Repo.insert()
  end

  def associate_with_project(users_ids, project_id) do
    associated_users = Enum.map(users_ids, fn u ->
      %{user_id: u, project_id: project_id}      
      end)
    Repo.insert_all(ProjectCollaborator,associated_users)
  end

  def delete_project(project_id) do
     project = Repo.get!(Project,project_id)
     Repo.delete(project) 
  end

  def delete_association_with_project(user_id,project_id) do
    Repo.get_by(ProjectCollaborator, project_id: project_id, user_id: user_id)
    |> Repo.delete()
  end

  def get_project(project_id) do
    Repo.get(Project,project_id)
  end

  def update_project(project, attrs, platforms_added, platforms_deleted) do
    {:ok, changed_project} = project
    |> Project.changeset(attrs)
    |> Repo.update()
    
    create_platforms_by_list(platforms_added,project.id)
    delete_platforms_by_list(platforms_deleted,project.id)
    platforms_after_changes = get_platform_by_project_id(project.id)
    {:ok, %{
      id: project.id,
      project_name: changed_project.project_name,
      basic_language: changed_project.basic_language,
      platforms: platforms_after_changes,
      languages: []}}
  end

  def create_platform(attrs) do
    %Platform{}
    |> Platform.changeset(attrs)
    |> Repo.insert()
  end

  def create_platforms_by_list(platforms, project_id) do
    platform = Enum.map(platforms, fn p ->
      %{platform_name: p , project_id: project_id}
      end)
    Repo.insert_all(Platform,platform)
  end

  def delete_platforms_by_list(platforms, project_id) do
    Platform
    |> where([p], p.platform_name in ^platforms and p.project_id == ^project_id)
    |> Repo.delete_all
  end

  def get_platform_by_project_id(project_id) do
    query = Query.from pl in Platform,
    join: p in Project,
    on: pl.project_id == p.id,
    where: pl.project_id == ^project_id
    Repo.all(query)
  end

  def get_platform_by_map(platforms, project_id) do
    Platform
    |> where([p], p.platform_name in ^Map.values(platforms) and p.project_id == ^project_id)
    |> Repo.all
  end

  def get_translation!(id), do: Repo.get!(Translation, id)

  def create_translation(params,file,user_id) do    
    map = parse_file(file)
    |> set_translation_properties(params,user_id)

    Repo.insert_all(Translation,map)
  end

  def parse_file(file) do
    File.stream!(file) |> xpath(~x"//trans-unit"l, 
    platform_key: ~x"//trans-unit/@id"s,
    basic: ~x"//source/text()"s,
    translation: ~x"//target/text()"s) 
  end

  def set_translation_properties(translation,params,user_id) do
    Enum.map(translation,fn r -> 
      %{project_id: params.project_id,
        platform_id: params.platform_id,
        user_id: user_id,
        language_id: params.language_id}
      |> Map.merge(r)  
      end)
  end

  def update_translation(%Translation{} = translation, attrs) do
    translation
    |> Translation.update_changeset(attrs)
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

  def create_language(params, file, user_id, platforms_map) do
    {:ok, language} = %Language{}
    |> Language.changeset(params)
    |> Repo.insert()

    platforms = get_platform_by_map(platforms_map,params.project_id)
    result = parse_file(file)
    
    map = Enum.map(platforms, fn pv ->
      Enum.map(result,fn r -> 
      %{project_id: String.to_integer(params.project_id),
        platform_id: pv.id,
        user_id: user_id,
        language_id: language.id}
      |> Map.merge(r)  
      end)
    end) 
    |> List.flatten()

    Repo.insert_all(Translation,map)
    {:ok ,get_language_with_edit_time(language.id, params.project_id)}
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

  def get_translation_for_project(project_id, language_id) do
    from(t in Translation,
      join: p in Platform,
      on: p.id == t.platform_id,
      where: t.project_id == ^project_id and t.language_id == ^language_id,
      select: %{t | platform_name: p.platform_name}
    )
    |> Repo.all()
  end

  def get_language_with_edit_time(language_id,project_id) do
    editor_query = 
      from(t in Translation,
        join: u in User, on: t.user_id == u.id,
        order_by: [desc: t.updated_at],
        select: u.name
      )
    
      from(l in Language,
        join: t in Translation,
        on: t.language_id==l.id and t.project_id == l.project_id,
        join: u in User, on: t.user_id == u.id,
        group_by: l.id,
        where: l.id == ^language_id and l.project_id == ^project_id,
        select: %{l | 
          strings_count: count(t.id),
          last_edit_time: max(t.updated_at)
        },
        preload: [last_editor_name: ^editor_query]
      )
    |> Repo.all
  end

end