defmodule Reverso.Web.ProjectController do
  use Reverso.Web, :controller

  alias Reverso.Projects
  alias Reverso.Projects.Project
  alias Reverso.Accounts.ProjectCollaborator

  action_fallback Reverso.Web.FallbackController

  def index(conn, _params) do
    project = Projects.list_project(conn.assigns[:current_user_id])
    render(conn, "index.json", project: project)
  end

  def create(conn, %{
    "basic_language" => basic_language,
    "project_name" => project_name,
    "platforms" => platforms}) do 

    project_params = %{
      project_name: project_name,
      basic_language: basic_language,
      owner_id: conn.assigns[:current_user_id]}

    case  Projects.create_project(project_params,platforms) do
      {:ok, %ProjectCollaborator{}} -> 
        project = Projects.list_project()
        conn
        |> put_status(:created)
        |> render("index.json", project: project)
    end
  end

  def update(conn, %{"id" => id, "project" => project_params}) do
    project = Projects.get_project!(id)

    with {:ok, %Project{} = project} <- Projects.update_project(project, project_params) do
      render(conn, "index.json", project: project)
    end
  end

  def delete(conn, %{"id" => id}) do
    project = Projects.get_project!(id)
    with {:ok, %Project{}} <- Projects.delete_project(project) do
      send_resp(conn, :no_content, "")
    end
  end
end
