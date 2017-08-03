defmodule Reverso.Web.TermController do
  use Reverso.Web, :controller
  alias Reverso.Projects
  alias Reverso.Projects.Term

  action_fallback Reverso.Web.FallbackController

  def index(conn, %{"project_id" => project_id, "language_id"=>language_id}) do
    terms = Projects.fetch_terms_by_language_id(language_id)
    render(conn, "index.json", terms: terms)
  end



end