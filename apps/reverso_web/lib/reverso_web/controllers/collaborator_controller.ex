defmodule Reverso.Web.CollaboratorController do
  use Reverso.Web, :controller 

  alias Reverso.Projects
  alias Reverso.Accounts
  alias Reverso.Accounts.ProjectCollaborator
  alias Reverso.Accounts.User
  alias Reverso.Accounts.Invitation

  action_fallback Reverso.Web.FallbackController

  def index(conn, _params) do
    collaborators = Accounts.fetch_collaborators()
    render(conn, "index.json", collaborators: collaborators)
  end

  def create(conn, %{"project_id" => project_id, "users_ids" => users,"email" => email}) do
    with {:ok, %User = user} <- Invitation.start_invitation(email),
         {_num,nil} <- Projects.associate_with_project(users, project_id) do
      IO.inspect(users)
      conn
      |> put_status(200)
      |> render("message.json", %{info: "Collaborator added"})
    end
  end

  def update_user_from_invitation(conn, invitation_set) do
    with {:ok, _} <- Invitation.update_invitation(invitation_set) do
      conn
      |> send_resp(200, "")
    else
      {:error, _} ->
        conn
        |> put_status(422)
        |> render("message.json", %{error: "User does not exist!"})
    end
  end

  def generate_invitation_url(%User{} = user) do
    Application.get_env(:reverso_web, :invitation_url) <> "?email=" <> user.email
  end
end
