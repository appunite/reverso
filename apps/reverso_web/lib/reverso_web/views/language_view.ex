defmodule Reverso.Web.LanguageView do
  use Reverso.Web, :view
  alias Reverso.Web.LanguageView

  def render("index.json", %{languages: languages}) do
    %{data: render_many(languages, LanguageView, "language.json")}
  end

  def render("show.json", %{language: language}) do
    %{data: render_one(language, LanguageView, "language.json")}
  end

  def render("list.json", %{languages: languages}) do
    %{data: render_many(languages, LanguageView, "language_list.json")}
  end

  def render("language.json", %{language: langauge}) do
    %{language_name: langauge.language_name}
  end

  def render("language_list.json", %{language: language}) do
    %{language_id: language.language_id,
      language_name: language.language_name,
      last_edit: language.last_edit,
      words_count: language.words_count,
      editor: language.editor
  }
  end
end
