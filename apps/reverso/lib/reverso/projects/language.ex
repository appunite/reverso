defmodule Reverso.Projects.Language do
  use Ecto.Schema
  import Ecto.Changeset
  alias Reverso.Projects.Language


  schema "projects_languages" do
    field :language_name, :string
    field :project_id, :integer

    field :strings_count, :integer, virtual: true, default: 0

    timestamps()
  end

  @doc false
  def changeset(%Language{} = language, attrs) do
    language
    |> cast(attrs, [:language_name,:project_id])
    |> validate_required([:language_name, :project_id])
  end
end
