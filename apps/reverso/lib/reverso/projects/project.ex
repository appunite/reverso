defmodule Reverso.Projects.Project do
  use Ecto.Schema
  import Ecto.Changeset
  alias Reverso.Projects.Project


  schema "projects_projects" do
    field :platform, :string
    field :title, :string
    field :code , :integer
    

    timestamps()
  end

  @doc false
  def changeset(%Project{} = project, attrs) do
    project
    |> cast(attrs, [:title, :platform, :code])
    |> validate_required([:title, :platform, :code])
  end
end
