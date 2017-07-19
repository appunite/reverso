defmodule Reverso.Web.LanguageView do
  use Reverso.Web, :view
  alias Reverso.Web.LanguageView

  def render("index.json", %{language: language, strings: strings}) do
    IO.inspect(strings)
    %{data: render_many(language, LanguageView, "language.json")}
  end

  def render("show.json", %{language: language}) do
    %{data: render_one(language, LanguageView, "language.json")}
  end

  def render("language.json", %{language: language}) do
    %{language: language.id,
      language_name: language.language_name}
  end
end
