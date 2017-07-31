defmodule Reverso.Web.CollaboratorView do
  use Reverso.Web, :view
  alias Reverso.Web.CollaboratorView

  def render("index.json", %{collaborators: collaborators}) do
    %{data: render_many(collaborators, CollaboratorView, "collaborator.json")}
  end

  def render("collaborator.json", %{collaborator: collaborator}) do
    %{user_id: collaborator.id,
      user_name: collaborator.name,
      user_email: collaborator.email}
  end

  def render("message.json", %{info: message}) do
    %{info: message}
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      email: user.email,
    }
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end
end
