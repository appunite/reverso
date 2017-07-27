defmodule Reverso.Accounts.Invitation do

  import Ecto.Query, warn: false
  alias Reverso.Repo
  alias Reverso.Accounts
  alias Reverso.Accounts.User

  def invitation(%{"email" => email, "user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.fetch_by_email(email),
         {:ok, %User{} = user} <- update_user_invitation(user, user_params) do
      {:ok, user}
    end
  end

  def create_user_invitation(attrs) do
    %User{}
    |> User.new_invitation_changeset(attrs)
    |> Repo.insert()
  end

  def update_user_invitation(%User{} = user, attrs) do
    user
    |> User.update_changeset(Map.put(attrs, "activation_token", Ecto.UUID.generate()))
    |> Repo.update()
  end
end
