defmodule Reverso.Web.TokenView do
  use Reverso.Web, :view

  def render("message.json", %{error: error}) do
    %{error: error}
  end

  def render("message.json", %{info: info}) do
    %{info: info}
  end
end
