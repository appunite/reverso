defmodule Reverso.Accounts.ProjectCollaborator do
  use Ecto.Schema
  import Ecto.Changeset
  alias Reverso.Accounts.ProjectCollaborator


  schema "collaborators" do
    field :user_id, :integer
    field :project_id, :integer
    
    timestamps()
  end

  @doc false
  def changeset(%ProjectCollaborator{} = collaborator, attrs) do
    collaborator
    |> cast(attrs, [:user_id,:project_id])
    |> validate_required([:user_id,:project_id])
  end
end

