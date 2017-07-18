defmodule Reverso.Projects.Platform do
  use Ecto.Schema
  import Ecto.Changeset
  alias Reverso.Projects.Platform


  schema "projects_platforms" do
    field :platform_name, :string
    field :project_id, :integer

    timestamps()
  end

  @doc false
  def changeset(%Platform{} = platform, attrs) do
    platform
    |> cast(attrs, [:platform_name,:project_id])
    |> validate_required([:platform_name, :project_id])
  end
end
