defmodule Reverso.Web.ProjectView do
  use Reverso.Web, :view
  alias Reverso.Web.ProjectView
  alias Reverso.Web.LanguageView
  alias Reverso.Web.PlatformView

  def render("index.json", %{projects: projects}) do 
    %{data: render_many(projects, ProjectView, "project.json")}
  end

  def render("show.json", %{project: project}) do
    %{data: render_one(project,ProjectView, "project.json")}
  end

  def render("project.json", %{project: project}) do
    data = %{id: project.id,
      project_name: project.project_name,
      basic_language: project.basic_language,
      platforms: render_many(project.platforms,PlatformView,"platform.json"),
      languages: render_many(project.languages,LanguageView,"language_list.json")}
  end
end
