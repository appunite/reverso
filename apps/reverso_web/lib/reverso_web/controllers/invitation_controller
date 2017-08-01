defmodule Reverso.Web.InvitationController do
  use Reverso.Web, :controller 

  alias Reverso.Accounts
  alias Reverso.Accounts.User
  alias Reverso.Accounts.Invitation

  action_fallback Reverso.Web.FallbackController

  def create(conn, invitation_set) do
    with {:ok, %User{} = user} <- Invitation.start_invitation(invitation_set) do
      conn
      |> send_resp(200, "")
    else
      {:error, :invitation_not_valid} ->
        conn
        |> send_resp(422, "")
    end
  end

  def update_user_from_invitation(conn, invitation_set) do
    with {:ok, _} <- Invitation.update_invitation(invitation_set),
         {:ok, _} <- Reverso.Email.send_activation_email(user) do
      conn
      |> send_resp(200, "")
    else
      {:error, _} ->
        conn
        |> send_resp(422, "")
    end
  end
end
