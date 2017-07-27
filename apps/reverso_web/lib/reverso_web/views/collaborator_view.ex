defmodule Reverso.Web.CollaboratorView do
  use Reverso.Web, :view
  alias Reverso.Web.CollaboratorView

  def render("index.json", %{collaborators: collaborators}) do
    %{data: render_many(collaborators, CollaboratorView, "collaborator.json")}
  end

  def render("collaborator.json", %{collaborator: collaborator}) do
    %{user_id: collaborator.user_id,
      user_name: collaborator.user_name,
      user_email: collaborator.user_email}
  end

  def render("message.json", %{info: message}) do
    %{info: message}
  end
end
