defmodule Reverso.Email do
  import Swoosh.Email

  def test_email(user) do
    new
    |> to({user.name, user.email})
    |> from({"test", "czupakabra96@gmail.com"})
    |> subject("test")
    |> html_body("<h1>Hello #{user.name}</h1>")
    |> text_body("Hello #{user.name}\n")
  end
end
