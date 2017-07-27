defmodule Reverso.Web.InvitationController do
  use Reverso.Web, :controller

  alias Reverso.Accounts
  alias Reverso.Accounts.User
  alias Reverso.Accounts.Invitation

  def generate_invitation_url(%User{} = user) do
    Application.get_env(:reverso_web, :invitation_url) <> "?email=" <> user.email
  end
end
