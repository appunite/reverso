defmodule Reverso.Web.ProjectView do
  use Reverso.Web, :view
  alias Reverso.Web.ProjectView

  def render("index.json", %{project: project}) do
    %{data: render_many(project, ProjectView, "project.json")}
  end

  def render("show.json", %{languages: languages}) do
    %{data: render_many(languages, ProjectView, "languagelist.json")}
  end

  def render("project.json", %{project: project}) do
    %{id: project.id,
      project_name: project.project_name,
      basic_language: project.basic_language}
  end

  def render("languagelist.json", %{project: languages}) do
    %{ languages: languages}
  end
end
