defmodule Reverso.Projects.Translation do
  use Ecto.Schema
  import Ecto.Changeset
  alias Reverso.Projects.Translation


  schema "projects_translations" do
    field :basic, :string
    field :platform_key, :string
    field :translation, :string

    field :platform_id, :integer
    field :language_id, :integer
    field :user_id, :integer
    field :project_id, :integer
    timestamps()
  end

  @doc false
  def changeset(%Translation{} = translation, attrs) do
    translation
    |> cast(attrs, [:basic, :translation, :platform_key, :platform_id, :language_id, :user_id, :project_id])
    |> validate_required([:basic, :translation, :platform_key, :platform_id, :language_id, :user_id, :project_id])
  end
end
