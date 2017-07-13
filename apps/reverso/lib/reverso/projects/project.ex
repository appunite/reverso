defmodule Reverso.Projects.Project do
  use Ecto.Schema
  import Ecto.Changeset
  alias Reverso.Projects.Project


  schema "projects_projects" do
    field :title, :string
    field :code , :integer


    timestamps()
  end

  @doc false
  def changeset(%Project{} = project, attrs) do
    project
    |> cast(attrs, [:title, :code])
    |> validate_required([:title, :code])
  end
end
