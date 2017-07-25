defmodule Reverso.Email do
  import Bamboo.Email
  use Bamboo.Phoenix, view: Reverso.Web.EmailView

  alias Reverso.Accounts.User

  def activation_email(%User{} = user) do
    new_email
    |> to(user.email)
    |> from("czupakabra96@gmail.com")
    |> put_html_layout({Reverso.Web.LayoutView, "email.html"})
    |> subject("REVERSO.co - activation")
    |> assign(:activation_adress, Reverso.Accounts.Token.generate_activation_url(user))
    |> render("activation_email.html")
  end

  def password_reset_email(%User{} = user) do
    new_email
    |> to(user.email)
    |> from("czupakabra96@gmail.com")
    |> subject("REVERSO.co - Password Reset")
    |> html_body("<strong>Welcome</strong>")
    |> text_body("welcome")
  end
end
