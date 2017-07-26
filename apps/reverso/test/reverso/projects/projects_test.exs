defmodule Reverso.ProjectsTest do
  use Reverso.DataCase

  alias Reverso.Projects

  alias Reverso.Repo
  alias Reverso.Projects.Project
  alias Reverso.Projects.Language
  alias Reverso.Accounts.User
  alias Reverso.Projects.Translation
  alias Reverso.Accounts.ProjectCollaborator

  test "list_project" do
    user = Repo.insert!(%User{name: "user"})
    project = Repo.insert!(%Project{})

    Repo.insert!(%ProjectCollaborator{
      user_id: user.id,
      project_id: project.id
    })

    english = Repo.insert!(%Language{
      project_id: project.id, language_name: "english"
    })
    french = Repo.insert!(%Language{
      project_id: project.id, language_name: "french"
    })

    user1 = Repo.insert!(%User{name: "user1"})
    user2 = Repo.insert!(%User{name: "user2"})
    user3 = Repo.insert!(%User{name: "user3"})
    user4 = Repo.insert!(%User{name: "user4"})

    _english_translation = Repo.insert!(%Translation{
          language_id: english.id, user_id: user2.id, project_id: project.id
                                       })
    _english_translation = Repo.insert!(%Translation{
          language_id: english.id, user_id: user3.id, project_id: project.id
                                        })

    _english_translation = Repo.insert!(%Translation{
          language_id: english.id, user_id: user4.id, project_id: project.id
                                        })


    english_translation = Repo.insert!(%Translation{
      language_id: english.id, user_id: user1.id, project_id: project.id
    })

    _french_translation = Repo.insert!(%Translation{
          language_id: french.id, user_id: user1.id, project_id: project.id
                                      })

    _french_translation = Repo.insert!(%Translation{
          language_id: french.id, user_id: user2.id, project_id: project.id
                                       })

    _french_translation = Repo.insert!(%Translation{
          language_id: french.id, user_id: user3.id, project_id: project.id
                                       })


    french_translation = Repo.insert!(%Translation{
      language_id: french.id, user_id: user4.id, project_id: project.id
    })

    [fetched_project | _] = Projects.fetch_projects(user.id)
    |> IO.inspect

    assert %{
      language_name: "english",
      strings_count: 1,
      last_editor_name: "user1",
      last_edit_time: english_translation.inserted_at
    } in fetched_project.languages
  end



  # describe "languages" do
  #   alias Reverso.Projects.Language

  #   @valid_attrs %{language: "some language"}
  #   @update_attrs %{language: "some updated language"}
  #   @invalid_attrs %{language: nil}

  #   def language_fixture(attrs \\ %{}) do
  #     {:ok, language} =
  #       attrs
  #       |> Enum.into(@valid_attrs)
  #       |> Projects.create_language()

  #     language
  #   end

  #   test "list_languages/0 returns all languages" do
  #     language = language_fixture()
  #     assert Projects.list_languages() == [language]
  #   end

  #   test "get_language!/1 returns the language with given id" do
  #     language = language_fixture()
  #     assert Projects.get_language!(language.id) == language
  #   end

  #   test "create_language/1 with valid data creates a language" do
  #     assert {:ok, %Language{} = language} = Projects.create_language(@valid_attrs)
  #     assert language.language == "some language"
  #   end

  #   test "create_language/1 with invalid data returns error changeset" do
  #     assert {:error, %Ecto.Changeset{}} = Projects.create_language(@invalid_attrs)
  #   end

  #   test "update_language/2 with valid data updates the language" do
  #     language = language_fixture()
  #     assert {:ok, language} = Projects.update_language(language, @update_attrs)
  #     assert %Language{} = language
  #     assert language.language == "some updated language"
  #   end

  #   test "update_language/2 with invalid data returns error changeset" do
  #     language = language_fixture()
  #     assert {:error, %Ecto.Changeset{}} = Projects.update_language(language, @invalid_attrs)
  #     assert language == Projects.get_language!(language.id)
  #   end

  #   test "delete_language/1 deletes the language" do
  #     language = language_fixture()
  #     assert {:ok, %Language{}} = Projects.delete_language(language)
  #     assert_raise Ecto.NoResultsError, fn -> Projects.get_language!(language.id) end
  #   end

  #   test "change_language/1 returns a language changeset" do
  #     language = language_fixture()
  #     assert %Ecto.Changeset{} = Projects.change_language(language)
  #   end
  # end

  # describe "projects" do
  #   alias Reverso.Projects.Project

  #   @valid_attrs %{platform: "some platform", title: "some title"}
  #   @update_attrs %{platform: "some updated platform", title: "some updated title"}
  #   @invalid_attrs %{platform: nil, title: nil}

  #   def project_fixture(attrs \\ %{}) do
  #     {:ok, project} =
  #       attrs
  #       |> Enum.into(@valid_attrs)
  #       |> Projects.create_project()

  #     project
  #   end

  #   test "list_projects/0 returns all projects" do
  #     project = project_fixture()
  #     assert Projects.list_projects() == [project]
  #   end

  #   test "get_project!/1 returns the project with given id" do
  #     project = project_fixture()
  #     assert Projects.get_project!(project.id) == project
  #   end

  #   test "create_project/1 with valid data creates a project" do
  #     assert {:ok, %Project{} = project} = Projects.create_project(@valid_attrs)
  #     assert project.platform == "some platform"
  #     assert project.title == "some title"
  #   end

  #   test "create_project/1 with invalid data returns error changeset" do
  #     assert {:error, %Ecto.Changeset{}} = Projects.create_project(@invalid_attrs)
  #   end

  #   test "update_project/2 with valid data updates the project" do
  #     project = project_fixture()
  #     assert {:ok, project} = Projects.update_project(project, @update_attrs)
  #     assert %Project{} = project
  #     assert project.platform == "some updated platform"
  #     assert project.title == "some updated title"
  #   end

  #   test "update_project/2 with invalid data returns error changeset" do
  #     project = project_fixture()
  #     assert {:error, %Ecto.Changeset{}} = Projects.update_project(project, @invalid_attrs)
  #     assert project == Projects.get_project!(project.id)
  #   end

  #   test "delete_project/1 deletes the project" do
  #     project = project_fixture()
  #     assert {:ok, %Project{}} = Projects.delete_project(project)
  #     assert_raise Ecto.NoResultsError, fn -> Projects.get_project!(project.id) end
  #   end

  #   test "change_project/1 returns a project changeset" do
  #     project = project_fixture()
  #     assert %Ecto.Changeset{} = Projects.change_project(project)
  #   end
  # end

  # describe "translations" do
  #   alias Reverso.Projects.Translation

  #   @valid_attrs %{basic: "some basic", translation: "some translation"}
  #   @update_attrs %{basic: "some updated basic", translation: "some updated translation"}
  #   @invalid_attrs %{basic: nil, translation: nil}

  #   def translation_fixture(attrs \\ %{}) do
  #     {:ok, translation} =
  #       attrs
  #       |> Enum.into(@valid_attrs)
  #       |> Projects.create_translation()

  #     translation
  #   end

  #   test "list_translations/0 returns all translations" do
  #     translation = translation_fixture()
  #     assert Projects.list_translations() == [translation]
  #   end

  #   test "get_translation!/1 returns the translation with given id" do
  #     translation = translation_fixture()
  #     assert Projects.get_translation!(translation.id) == translation
  #   end

  #   test "create_translation/1 with valid data creates a translation" do
  #     assert {:ok, %Translation{} = translation} = Projects.create_translation(@valid_attrs)
  #     assert translation.basic == "some basic"
  #     assert translation.translation == "some translation"
  #   end

  #   test "create_translation/1 with invalid data returns error changeset" do
  #     assert {:error, %Ecto.Changeset{}} = Projects.create_translation(@invalid_attrs)
  #   end

  #   test "update_translation/2 with valid data updates the translation" do
  #     translation = translation_fixture()
  #     assert {:ok, translation} = Projects.update_translation(translation, @update_attrs)
  #     assert %Translation{} = translation
  #     assert translation.basic == "some updated basic"
  #     assert translation.translation == "some updated translation"
  #   end

  #   test "update_translation/2 with invalid data returns error changeset" do
  #     translation = translation_fixture()
  #     assert {:error, %Ecto.Changeset{}} = Projects.update_translation(translation, @invalid_attrs)
  #     assert translation == Projects.get_translation!(translation.id)
  #   end

  #   test "delete_translation/1 deletes the translation" do
  #     translation = translation_fixture()
  #     assert {:ok, %Translation{}} = Projects.delete_translation(translation)
  #     assert_raise Ecto.NoResultsError, fn -> Projects.get_translation!(translation.id) end
  #   end

  #   test "change_translation/1 returns a translation changeset" do
  #     translation = translation_fixture()
  #     assert %Ecto.Changeset{} = Projects.change_translation(translation)
  #   end
  # end

  # describe "project" do
  #   alias Reverso.Projects.Project

  #   @valid_attrs %{basic_language: "some basic_language", project_name: "some project_name"}
  #   @update_attrs %{basic_language: "some updated basic_language", project_name: "some updated project_name"}
  #   @invalid_attrs %{basic_language: nil, project_name: nil}

  #   def project_fixture(attrs \\ %{}) do
  #     {:ok, project} =
  #       attrs
  #       |> Enum.into(@valid_attrs)
  #       |> Projects.create_project()

  #     project
  #   end

  #   test "list_project/0 returns all project" do
  #     project = project_fixture()
  #     assert Projects.list_project() == [project]
  #   end

  #   test "get_project!/1 returns the project with given id" do
  #     project = project_fixture()
  #     assert Projects.get_project!(project.id) == project
  #   end

  #   test "create_project/1 with valid data creates a project" do
  #     assert {:ok, %Project{} = project} = Projects.create_project(@valid_attrs)
  #     assert project.basic_language == "some basic_language"
  #     assert project.project_name == "some project_name"
  #   end

  #   test "create_project/1 with invalid data returns error changeset" do
  #     assert {:error, %Ecto.Changeset{}} = Projects.create_project(@invalid_attrs)
  #   end

  #   test "update_project/2 with valid data updates the project" do
  #     project = project_fixture()
  #     assert {:ok, project} = Projects.update_project(project, @update_attrs)
  #     assert %Project{} = project
  #     assert project.basic_language == "some updated basic_language"
  #     assert project.project_name == "some updated project_name"
  #   end

  #   test "update_project/2 with invalid data returns error changeset" do
  #     project = project_fixture()
  #     assert {:error, %Ecto.Changeset{}} = Projects.update_project(project, @invalid_attrs)
  #     assert project == Projects.get_project!(project.id)
  #   end

  #   test "delete_project/1 deletes the project" do
  #     project = project_fixture()
  #     assert {:ok, %Project{}} = Projects.delete_project(project)
  #     assert_raise Ecto.NoResultsError, fn -> Projects.get_project!(project.id) end
  #   end

  #   test "change_project/1 returns a project changeset" do
  #     project = project_fixture()
  #     assert %Ecto.Changeset{} = Projects.change_project(project)
  #   end
  # end

  # describe "platforms" do
  #   alias Reverso.Projects.Platform

  #   @valid_attrs %{platform_name: "some platform_name"}
  #   @update_attrs %{platform_name: "some updated platform_name"}
  #   @invalid_attrs %{platform_name: nil}

  #   def platform_fixture(attrs \\ %{}) do
  #     {:ok, platform} =
  #       attrs
  #       |> Enum.into(@valid_attrs)
  #       |> Projects.create_platform()

  #     platform
  #   end

  #   test "list_platforms/0 returns all platforms" do
  #     platform = platform_fixture()
  #     assert Projects.list_platforms() == [platform]
  #   end

  #   test "get_platform!/1 returns the platform with given id" do
  #     platform = platform_fixture()
  #     assert Projects.get_platform!(platform.id) == platform
  #   end

  #   test "create_platform/1 with valid data creates a platform" do
  #     assert {:ok, %Platform{} = platform} = Projects.create_platform(@valid_attrs)
  #     assert platform.platform_name == "some platform_name"
  #   end

  #   test "create_platform/1 with invalid data returns error changeset" do
  #     assert {:error, %Ecto.Changeset{}} = Projects.create_platform(@invalid_attrs)
  #   end

  #   test "update_platform/2 with valid data updates the platform" do
  #     platform = platform_fixture()
  #     assert {:ok, platform} = Projects.update_platform(platform, @update_attrs)
  #     assert %Platform{} = platform
  #     assert platform.platform_name == "some updated platform_name"
  #   end

  #   test "update_platform/2 with invalid data returns error changeset" do
  #     platform = platform_fixture()
  #     assert {:error, %Ecto.Changeset{}} = Projects.update_platform(platform, @invalid_attrs)
  #     assert platform == Projects.get_platform!(platform.id)
  #   end

  #   test "delete_platform/1 deletes the platform" do
  #     platform = platform_fixture()
  #     assert {:ok, %Platform{}} = Projects.delete_platform(platform)
  #     assert_raise Ecto.NoResultsError, fn -> Projects.get_platform!(platform.id) end
  #   end

  #   test "change_platform/1 returns a platform changeset" do
  #     platform = platform_fixture()
  #     assert %Ecto.Changeset{} = Projects.change_platform(platform)
  #   end
  # end

  # describe "translations" do
  #   alias Reverso.Projects.Translation

  #   @valid_attrs %{basic: "some basic", platform_key: "some platform_key", translation: "some translation"}
  #   @update_attrs %{basic: "some updated basic", platform_key: "some updated platform_key", translation: "some updated translation"}
  #   @invalid_attrs %{basic: nil, platform_key: nil, translation: nil}

  #   def translation_fixture(attrs \\ %{}) do
  #     {:ok, translation} =
  #       attrs
  #       |> Enum.into(@valid_attrs)
  #       |> Projects.create_translation()

  #     translation
  #   end

  #   test "list_translations/0 returns all translations" do
  #     translation = translation_fixture()
  #     assert Projects.list_translations() == [translation]
  #   end

  #   test "get_translation!/1 returns the translation with given id" do
  #     translation = translation_fixture()
  #     assert Projects.get_translation!(translation.id) == translation
  #   end

  #   test "create_translation/1 with valid data creates a translation" do
  #     assert {:ok, %Translation{} = translation} = Projects.create_translation(@valid_attrs)
  #     assert translation.basic == "some basic"
  #     assert translation.platform_key == "some platform_key"
  #     assert translation.translation == "some translation"
  #   end

  #   test "create_translation/1 with invalid data returns error changeset" do
  #     assert {:error, %Ecto.Changeset{}} = Projects.create_translation(@invalid_attrs)
  #   end

  #   test "update_translation/2 with valid data updates the translation" do
  #     translation = translation_fixture()
  #     assert {:ok, translation} = Projects.update_translation(translation, @update_attrs)
  #     assert %Translation{} = translation
  #     assert translation.basic == "some updated basic"
  #     assert translation.platform_key == "some updated platform_key"
  #     assert translation.translation == "some updated translation"
  #   end

  #   test "update_translation/2 with invalid data returns error changeset" do
  #     translation = translation_fixture()
  #     assert {:error, %Ecto.Changeset{}} = Projects.update_translation(translation, @invalid_attrs)
  #     assert translation == Projects.get_translation!(translation.id)
  #   end

  #   test "delete_translation/1 deletes the translation" do
  #     translation = translation_fixture()
  #     assert {:ok, %Translation{}} = Projects.delete_translation(translation)
  #     assert_raise Ecto.NoResultsError, fn -> Projects.get_translation!(translation.id) end
  #   end

  #   test "change_translation/1 returns a translation changeset" do
  #     translation = translation_fixture()
  #     assert %Ecto.Changeset{} = Projects.change_translation(translation)
  #   end
  # end

  # describe "languages" do
  #   alias Reverso.Projects.Language

  #   @valid_attrs %{language_name: "some language_name"}
  #   @update_attrs %{language_name: "some updated language_name"}
  #   @invalid_attrs %{language_name: nil}

  #   def language_fixture(attrs \\ %{}) do
  #     {:ok, language} =
  #       attrs
  #       |> Enum.into(@valid_attrs)
  #       |> Projects.create_language()

  #     language
  #   end

  #   test "list_languages/0 returns all languages" do
  #     language = language_fixture()
  #     assert Projects.list_languages() == [language]
  #   end

  #   test "get_language!/1 returns the language with given id" do
  #     language = language_fixture()
  #     assert Projects.get_language!(language.id) == language
  #   end

  #   test "create_language/1 with valid data creates a language" do
  #     assert {:ok, %Language{} = language} = Projects.create_language(@valid_attrs)
  #     assert language.language_name == "some language_name"
  #   end

  #   test "create_language/1 with invalid data returns error changeset" do
  #     assert {:error, %Ecto.Changeset{}} = Projects.create_language(@invalid_attrs)
  #   end

  #   test "update_language/2 with valid data updates the language" do
  #     language = language_fixture()
  #     assert {:ok, language} = Projects.update_language(language, @update_attrs)
  #     assert %Language{} = language
  #     assert language.language_name == "some updated language_name"
  #   end

  #   test "update_language/2 with invalid data returns error changeset" do
  #     language = language_fixture()
  #     assert {:error, %Ecto.Changeset{}} = Projects.update_language(language, @invalid_attrs)
  #     assert language == Projects.get_language!(language.id)
  #   end

  #   test "delete_language/1 deletes the language" do
  #     language = language_fixture()
  #     assert {:ok, %Language{}} = Projects.delete_language(language)
  #     assert_raise Ecto.NoResultsError, fn -> Projects.get_language!(language.id) end
  #   end

  #   test "change_language/1 returns a language changeset" do
  #     language = language_fixture()
  #     assert %Ecto.Changeset{} = Projects.change_language(language)
  #   end
  # end
end
