defmodule Reverso.Email do
  import Bamboo.Email

  alias Reverso.Accounts.User

  def activation_email() do
    new_email
    |> to("example@example.com")
    |> from("noreply@reverso.co")
    |> subject("REVERSO.co - activation")
    |> html_body("<strong>Welcome</strong>")
    |> text_body("welcome")
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
