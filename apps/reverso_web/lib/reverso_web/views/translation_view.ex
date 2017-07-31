defmodule Reverso.Web.TranslationView do
  use Reverso.Web, :view
  alias Reverso.Web.TranslationView

  def render("index.json", %{translations: translations}) do
    %{data: render_many(translations, TranslationView, "translation.json")}
  end

  def render("show.json", %{translation: translation}) do
    %{data: render_one(translation, TranslationView, "translation.json")}
  end

  def render("translation.json", %{translation: translation}) do
    %{id: translation.id,
      basic: translation.basic,
      translation: translation.translation,
      platform_key: translation.platform_key,
      platform_name: translation.platform_name
    }
  end
end
