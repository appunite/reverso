defmodule Reverso.Web.ProjectController do
  use Reverso.Web, :controller

  alias Reverso.Projects
  alias Reverso.Projects.Project
  
  action_fallback Reverso.Web.FallbackController

  def index(conn, _params) do
    projects = Projects.list_project(conn.assigns[:current_user_id])
    render(conn, "index.json", projects: projects)
  end

  def create(conn, %{
    "basic_language" => basic_language,
    "project_name" => project_name,
    "platforms" => platforms}) do

    project_params = %{
      project_name: project_name,
      basic_language: basic_language,
      owner_id: conn.assigns[:current_user_id]}

    with {:ok, project} <-
      Projects.create_project(project_params,platforms) do
        conn
        |> put_status(:created)
        |> render("show.json", project: project)
    end
  end

  def update(conn, %{
    "basic_language" => basic_langauge,
    "id" => id,
    "project_name" => project_name,
    "platforms_added" => platforms_added,
    "platforms_removed" => platforms_removed}) do

    project_params = %{
      project_name: project_name,
      basic_language: basic_language}
    project = Projects.get_project(id)

    with {:ok, %Project{} = project} <-
    Projects.update_project(project, project_params, platforms_added, platforms_removed) do
      render(conn, "index.json", project: project)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %Project{}} <- Projects.delete_project(id) do
      send_resp(conn, :no_content, "")
    end
  end

end
