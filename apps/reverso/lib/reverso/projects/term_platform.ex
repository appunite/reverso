defmodule Reverso.Projects.TermPlatform do
  use Ecto.Schema
  import Ecto.Changeset
  alias Reverso.Projects.TermPlatform


  schema "term_platform" do
    field :platform_id, :integer
    field :term_id, :integer
    field :platform_key, :string
    
    timestamps()
  end

  @doc false
  def changeset(%TermPlatform{} = term_platform, attrs) do
    term_platform
    |> cast(attrs, [:platform_id, :term_id, :platform_key])
    |> validate_required([:platform_id, :term_id, :platform_key])
  end
end

