defmodule Reverso.Projects.Translation do
  use Ecto.Schema
  import Ecto.Changeset
  alias Reverso.Projects.Translation


  schema "projects_translations" do
    field :basic, :string
    field :translation, :string
    belongs_to :project, Reverso.Projects.Project

    timestamps()
  end

  @doc false
  def changeset(%Translation{} = translation, attrs) do
    translation
    |> cast(attrs, [:basic, :translation])
    |> validate_required([:basic, :translation])
  end
end
