defmodule Reverso.Web.SessionView do
  use Reverso.Web, :view

  def render("token.json", %{user: user}) do
    %{auth_token: user.user_token}
  end

  def render("session.json", %{user: user}) do
    %{
      id: user.id,
      email: user.email,
      name: user.name,
      user_token: user.user_token
    }
  end

  def render("message.json", %{error: error}) do
    %{error: error}
  end
end
