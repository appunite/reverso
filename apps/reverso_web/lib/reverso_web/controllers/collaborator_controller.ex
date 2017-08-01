defmodule Reverso.Web.CollaboratorController do
  use Reverso.Web, :controller 

  alias Reverso.Projects
  alias Reverso.Accounts

  action_fallback Reverso.Web.FallbackController

  def index(conn, _params) do
    collaborators = Accounts.fetch_collaborators()
    render(conn, "index.json", collaborators: collaborators)
  end

  def create(conn, %{
        "project_id" => project_id,
        "users_ids" => users,}) do
    with {_num,nil} <- Projects.associate_with_project(users, project_id) do
      conn
      |> put_status(200)
      |> render("message.json", %{info: "Collaborator added"})
    end
  end
end
