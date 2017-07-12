defmodule Reverso.Web.UserView do
  use Reverso.Web, :view
  alias Reverso.Web.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      email: user.email,
      crypted_password: user.crypted_password,
      name: user.name}
  end
end