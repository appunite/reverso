defmodule Reverso.Web.PlatformView do
  use Reverso.Web, :view
  alias Reverso.Web.PlatformView

  def render("platform.json", %{platform: platform}) do
    %{platform_name: platform.platform_name}
  end
end
