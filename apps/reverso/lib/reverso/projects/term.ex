defmodule Reverso.Projects.Term do
  use Ecto.Schema
  import Ecto.Changeset
  alias Reverso.Projects.Term


  schema "terms" do
    field :text, :string
    field :user_id, :integer
    field :language_id, :integer
    field :translation_id, :string
  
    timestamps()
  end

  @doc false
  def changeset(%Term{} = term, attrs) do
    term
    |> cast(attrs, [:text,:user_id,:language_id,:translation_id])
    |> validate_required([:text,:user_id,:language_id,:translation_id])
  end
end
