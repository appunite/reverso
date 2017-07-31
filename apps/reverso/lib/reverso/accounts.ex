defmodule Reverso.Accounts do

  import Ecto.Query, warn: false
  alias Reverso.Repo
  
  alias Reverso.Accounts.User
  alias Reverso.Accounts.ProjectCollaborator
  alias Reverso.Projects.Project


  def list_users do
    Repo.all(User)
  end

  def fetch_collaborators() do
    from(c in ProjectCollaborator,
      join: p in Project,
      on: c.project_id == p.id,
      join: u in User,
      on: c.user_id == u.id,
      select: %{id: u.id, name: u.name, email: u.email, project_id: c.project_id}
    )
    |> Repo.all
  end

  def create_user(attrs) do
    %User{}
    |> User.changeset(Map.put(attrs, "activation_token", Ecto.UUID.generate()))
    |> Repo.insert()
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.update_changeset(attrs)
    |> Repo.update()
  end

  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  def fetch_by_id(id) do
    with %User{} = user <- Repo.get_by(User,id: id) do
      {:ok, user}
    else
      _ -> {:error, :user_not_found}
    end
  end

  def fetch_by_password_token(token) do
    with %User{} = user <- Repo.get_by(User,password_reset_token: token) do
      {:ok, user}
    else
      _ -> {:error, :user_not_found}
    end
  end

  def fetch_by_user_token(token) do
    with %User{} = user <- Repo.get_by(User,user_token: token) do
      {:ok, user}
    else
      _ -> {:error, :user_not_found}
    end
  end

  def fetch_by_invitation_token(token) do
    with %User{} = user <- Repo.get_by(User,invitation_token: token) do
      {:ok, user}
    else
      _ -> {:error, :user_not_found}
    end
  end

  def fetch_by_email(email)do
    with %User{} = user <- Repo.get_by(User,email: email) do
      {:ok, user}
    else
      _ -> {:error, :user_not_found}
    end
  end
end
