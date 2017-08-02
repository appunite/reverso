defmodule Reverso.Accounts.Invitation do

  import Ecto.Query, warn: false
  alias Reverso.Repo
  alias Reverso.Accounts
  alias Reverso.Accounts.User

  def update_invitation(%{
      "invitation_token" => invitation_token,
      "user" => user_params,
      "project_id" => project_id}) do
    with {:ok, %User{} = user} <- Accounts.fetch_by_invitation_token(invitation_token),
         {:ok, %User{} = user} <- update_user_invitation(user, user_params),
         {_num,nil} <- Reverso.Projects.associate_with_project([user.id], String.to_integer(project_id)) do
      {:ok, user}
    else
      {:error, _} -> {:error, :invitation_not_valid}
    end
  end

  def create_user_invitation(attrs) do
    %User{}
    |> User.new_invitation_changeset(Map.put(attrs, "invitation_token", Ecto.UUID.generate()))
    |> Repo.insert()
  end

  def update_user_invitation(%User{} = user, attrs) do
    user
    |> User.invitation_update_changeset(Map.put(attrs, "activation_token", Ecto.UUID.generate()))
    |> Repo.update()
  end

  def start_invitation(%{"email" => email, "project_id" => project_id}) do
    with {:ok, %User{} = user} <- create_user_invitation(%{"email" => email}),
         {:ok, _} <- Reverso.Email.send_invitation_email(user, project_id) do
      {:ok, user}
    else
      {:error, _} -> {:error, :invitation_not_valid}
    end
  end

  def generate_invitation_url(%User{} = user, project_id) do
    Application.get_env(:reverso_web, :invitation_url)
    <> "?invitation_token="
    <> user.invitation_token
    <> "&email="
    <> user.email
    <> "&project_id="
    <> Integer.to_string(project_id)
  end
end
