defmodule Reverso.Projects.Project do
  use Ecto.Schema
  import Ecto.Changeset
  alias Reverso.Projects.Project


  schema "projects_projects" do
    field :basic_language, :string
    field :project_name, :string
    field :owner_id, :integer

    field :number_of_languages, :integer, virtual: true, default: 0

    has_many :languages, Reverso.Projects.Language
    has_many :platforms, Reverso.Projects.Platform

    timestamps()
  end

  @doc false
  def changeset(%Project{} = project, attrs) do
    project
    |> cast(attrs, [:project_name, :basic_language, :owner_id])
    |> validate_required([:project_name, :basic_language, :owner_id])
  end
end
