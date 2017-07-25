defmodule Reverso.Email do
  import Bamboo.Email
  use Bamboo.Phoenix, view: Reverso.Web.EmailView

  alias Reverso.Accounts.User

  def send_activation_email(%User{} = user) do
    with %Bamboo.Email{} = email <- activation_email(user) do
      {:ok, user}
    else
      _ -> {:error, :user_not_found}
    end
  end 

  defp activation_email(%User{} = user) do
    new_email
    |> to(user.email)
    |> from("noreply@reverso.co")
    |> put_html_layout({Reverso.Web.LayoutView, "email.html"})
    |> subject("REVERSO.co - activation")
    |> assign(:activation_adress, Reverso.Web.TokenController.generate_activation_url(user))
    |> render("activation_email.html")
  end

  defp password_reset_email(%User{} = user) do
    new_email
    |> to(user.email)
    |> from("noreply@reverso.co")
    |> put_html_layout({Reverso.Web.LayoutView, "email.html"})
    |> subject("REVERSO.co - Password Reset")
    |> assign(:activation_adress, Reverso.Web.TokenController.generate_password_reset_url(user))
    |> render("password_reset_email.html")
  end
end
