defmodule Reverso.Projects do

  import Ecto.Query, warn: false
  alias Reverso.Repo
  alias Ecto.Query
  alias Reverso.Projects
  alias Reverso.Projects.Project
  alias Reverso.Projects.Term
  alias Reverso.Projects.TermPlatform
  alias Reverso.Projects.Language
  alias Reverso.Projects.Platform
  alias Reverso.Accounts.ProjectCollaborator
  alias Reverso.Accounts.User
  import Reverso.SweetXml

  def fetch_projects(user_id) do
    editor_query = 
      from(t in Term,
        join: u in User, on: t.user_id == u.id,
        order_by: [desc: t.updated_at],
        select: u.name
      )
    languages_query = 
      from(l in Language,
        left_join: t in Term, on: t.language_id == l.id,
        left_join: u in User, on: t.user_id == u.id,
        group_by: l.id,
        select: %{l |
          strings_count: count(t.id),
          last_edit_time: max(t.updated_at)
        },
        preload: [last_editor_name: ^editor_query]
      )
    collaborator_query =
      from(c in ProjectCollaborator,
        join: p in Project, on: c.project_id == p.id,
        join: u in User, on: c.user_id == u.id,
        select: u
      )

    result = from(p in Project,
      join: c in ProjectCollaborator,
      join: pl in assoc(p, :platforms),
      on: p.id == c.project_id and c.user_id == ^user_id,
      where: pl.project_id == p.id,
      preload: [
        languages: ^languages_query,
        collaborators: ^collaborator_query,
        platforms: pl
      ]
    ) 
    |> Repo.all

    Enum.map(result, fn project ->
      sum = Enum.map(project.languages, fn l ->
        l.strings_count
      end)    

      reference_language = Enum.find(project.languages, fn(language) -> 
        language.language_name == project.basic_language        
      end)   

      %{project |
        number_of_languages: length(project.languages),
        sum_of_strings: Enum.sum(sum),
        reference_language: reference_language
      }
    end)
  end

  def fetch_project_info(project_id,language_id) do
    editor_query =
      from(t in Term,
        join: u in User, on: t.user_id == u.id,
        order_by: [desc: t.updated_at],
        select: u.name
      )

    languages_query =
      from(l in Language,
        left_join: t in Term, on: t.language_id == l.id,
        where: l.id == ^language_id,
        left_join: u in User, on: t.user_id == u.id,
        group_by: l.id,
        select: %{l |
          strings_count: count(t.id),
          last_edit_time: max(t.updated_at)
        },
        preload: [last_editor_name: ^editor_query]
      )

    result = from(p in Project,
      join: c in ProjectCollaborator, on: c.project_id == p.id,
      join: pl in assoc(p, :platforms), on: pl.project_id == p.id,
      where: p.id == ^project_id,
      preload: [languages: ^languages_query],
      preload: [platforms: pl]
    )
    |> Repo.one()

    %{result | 
      number_of_languages: length(result.languages),
    }

  end

  def fetch_project_info(project_id) do
    editor_query =
      from(t in Term,
        join: u in User, on: t.user_id == u.id,
        order_by: [desc: t.updated_at],
        select: u.name
      )

    languages_query =
      from(l in Language,
        left_join: t in Term, on: t.language_id == l.id,
        left_join: u in User, on: t.user_id == u.id,
        group_by: l.id,
        select: %{l |
          strings_count: count(t.id),
          last_edit_time: max(t.updated_at)
        },
        preload: [last_editor_name: ^editor_query]
      )

    result = from(p in Project,
      join: c in ProjectCollaborator, on: c.project_id == p.id,
      join: pl in assoc(p, :platforms), on: pl.project_id == p.id,
      where: p.id == ^project_id,
      preload: [languages: ^languages_query],
      preload: [platforms: pl]
    )
    |> Repo.one()

    %{result | 
      number_of_languages: length(result.languages),
    }

  end

  def create_project(attrs, platforms) do
   {:ok, project} =  %Project{}
    |> Project.changeset(attrs)
    |> Repo.insert()

    {:ok, language} = create_reference_language(project)
    create_platforms_by_list(platforms,project.id)
    associate_project_owner(project.owner_id, project.id)
    platforms_after_changes = get_platform_by_project_id(project.id)
    associate_project_basic_language(project, %{basic_language_id: language.id})    

    {:ok, fetch_project_info(project.id, language.id)}
  end

  def create_reference_language(project) do
    params = %{language_name: project.basic_language, project_id: project.id}
    %Language{}
    |> Language.changeset(params)
    |> Repo.insert()
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

  def associate_project_basic_language(project, language_id) do
    project 
    |> Project.basic_language_changeset(language_id)
    |> Repo.update()
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
    language = get_language_by_name(project.id, attrs.basic_language)
     params = %{
       basic_language_id: language.id,
       basic_language: attrs.basic_language,
       project_name: attrs.project_name
     }

    {:ok, changed_project} = project
    |> Project.update_changeset(params)
    |> Repo.update()

    create_platforms_by_list(platforms_added,project.id)
    delete_platforms_by_list(platforms_deleted,project.id)
    {:ok, fetch_project_info(project.id)}
  end

  def get_language_by_name(project_id, language_name) do
    from(l in Language,
      where: l.language_name == ^language_name and l.project_id == ^project_id
    )
    |> Repo.one
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

  def create_language(params, file, user_id, platforms_map) do
    {:ok, language} = %Language{}
    |> Language.changeset(params)
    |> Repo.insert()

    platforms = get_platform_by_map(platforms_map,params.project_id)
    project = get_project(params.project_id)   
    result = parse_file(file)

    Enum.map(result, fn single_record -> 
      id = Ecto.UUID.generate
      
      Repo.insert(%Term{text: single_record.basic,
        translation_id: id,
        language_id: project.basic_language_id,
        user_id: user_id})

      {:ok, term} = Repo.insert(%Term{
          text: single_record.translation,
          translation_id: id,
          language_id: language.id,
          user_id: user_id
        })
      Enum.map(platforms, fn platform -> 
        Repo.insert(%TermPlatform{
          platform_id: platform.id,
          term_id: term.id,
          platform_key: single_record.platform_key
        })
      end)  
    end)
    
  
    {:ok, get_language_with_edit_time(language.id, params.project_id)}
  end

  def list_languages do
    query = Ecto.Query.from l in Language,
    distinct: true,
    select: %{language_name: l.language_name}
    Repo.all(query)
  end

  def get_language!(id), do: Repo.get!(Language, id)

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

   def fetch_terms_by_language_id(language_id) do
    from(t in Term,
      left_join: tm in Term, on: t.translation_id == tm.translation_id,
      where: t.language_id != tm.language_id and tm.language_id == ^language_id,
      select: %{basic_id: t.id, basic: t.text, translation_id: tm.id, translation: tm.text}
    )
    |> Repo.all()
  end

  def get_language_with_edit_time(language_id,project_id) do
    editor_query = 
      from(t in Term,
        join: u in User, on: t.user_id == u.id,
        order_by: [desc: t.updated_at],
        select: u.name
      )
    
      from(l in Language,
        join: t in Term,
        on: t.language_id==l.id,
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