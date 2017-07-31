defmodule Reverso.Accounts.Invitation do

  import Ecto.Query, warn: false
  alias Reverso.Repo
  alias Reverso.Accounts
  alias Reverso.Accounts.User

  def update_invitation(%{"email" => email, "user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.fetch_by_email(email),
         {:ok, %User{} = user} <- update_user_invitation(user, user_params) do
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
    |> User.update_changeset(Map.put(attrs, "activation_token", Ecto.UUID.generate()))
    |> Repo.update()
  end

  def start_invitation(email) do
    with {:ok, %User{} = user} <- create_user_invitation(%{"email" => email}),
         {:ok, _} <- Reverso.Email.send_invitation_email(user) do
      {:ok, user}
    else
      {:error, _} -> {:error, :invitation_not_valid}
    end
  end
end
