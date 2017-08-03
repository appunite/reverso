defmodule Reverso.Web.TermView do
  use Reverso.Web, :view
  alias Reverso.Web.TermView

  def render("index.json", %{terms: terms}) do
    %{data: render_many(terms, TermView, "term.json")}
  end

  def render("term.json", %{term: term}) do
    %{
      basic: %{
        basic_id: term.basic_id,
        basic: term.basic
      },
      translation: %{
        translation_id: term.translation_id,
        translation: term.translation
      }
    }
  end
end
