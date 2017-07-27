defmodule Reverso.Web.InvitationController do
  use Reverso.Web, :controller

  alias Reverso.Accounts.User
  alias Reverso.Accounts.Invitation

  def start_invitation(conn, email_struct) do
    with {:ok, %User{} = user} <- Invitation.create_user_invitation(email_struct),
         {:ok, _} <- Reverso.Email.send_reset_password_email(user) do
      conn
      |> send_resp(200, "")
    else
      {:error, _} -> 
        conn
        |> put_status(422)
        |> render("message.json", %{error: "User does not exist!"})
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
