defmodule Reverso.Projects.Language do
  use Ecto.Schema
  import Ecto.Changeset
  alias Reverso.Projects.Language


  schema "projects_languages" do
    field :language, :string
    has_many :projects, Reverso.Projects.Project

    timestamps()
  end

  @doc false
  def changeset(%Language{} = language, attrs) do
    language
    |> cast(attrs, [:language])
    |> validate_required([:language])
  end
end
