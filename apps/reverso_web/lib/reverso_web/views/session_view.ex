defmodule Reverso.Web.SessionView do
  use Reverso.Web, :view

  def render("token.json", %{user: user}) do
    %{auth_token: user.user_token}
  end
end
