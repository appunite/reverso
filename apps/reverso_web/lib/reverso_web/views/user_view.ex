defmodule Reverso.Web.UserView do
  use Reverso.Web, :view
  alias Reverso.Web.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      email: user.email,
      name: user.name
    }
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("message.json", %{error: error}) do
    %{error: error}
  end

  def render("message.json", %{info: info}) do
    %{info: info}
  end
end
