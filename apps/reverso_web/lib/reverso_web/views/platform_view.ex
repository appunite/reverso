defmodule Reverso.Web.PlatformView do
  use Reverso.Web, :view
  alias Reverso.Web.PlatformView

  def render("index.json", %{platforms: platforms}) do
    %{data: render_many(platforms, PlatformView, "platform.json")}
  end

  def render("show.json", %{platform: platform}) do
    %{data: render_one(platform, PlatformView, "platform.json")}
  end

  def render("platform.json", %{platform: platform}) do
    %{id: platform.id,
      platform_name: platform.platform_name}
  end
end
