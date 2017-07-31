defmodule Reverso.Email do
  import Bamboo.Email
  use Bamboo.Phoenix, view: Reverso.Web.EmailView

  alias Reverso.Accounts.User

  def send_invitation_email(%User{} = user) do
    with %Bamboo.Email{} = email <- invitation_email(user),
         %Bamboo.Email{} = _email <- Reverso.Mailer.deliver_later(email) do
      {:ok, user}
    else
      _ -> {:error, :user_not_found}
    end
  end

  def send_activation_email(%User{} = user) do
    with %Bamboo.Email{} = email <- activation_email(user),
         %Bamboo.Email{} = _email <- Reverso.Mailer.deliver_later(email) do
      {:ok, user}
    else
      _ -> {:error, :user_not_found}
    end
  end

  def send_reset_password_email(%User{} = user) do
    with %Bamboo.Email{} = email <- password_reset_email(user),
         %Bamboo.Email{} = _email <- Reverso.Mailer.deliver_later(email) do
      {:ok, user}
    else
      _ -> {:error, :user_not_found}
    end
  end

  defp activation_email(%User{} = user) do
    new_email()
    |> to(user.email)
    |> from("noreply@reverso.co")
    |> put_html_layout({Reverso.Web.LayoutView, "email.html"})
    |> subject("REVERSO.co - activation")
    |> assign(:activation_adress, Reverso.Web.AccountController.generate_activation_url(user))
    |> render("activation_email.html")
  end

  defp password_reset_email(%User{} = user) do
    new_email()
    |> to(user.email)
    |> from("noreply@reverso.co")
    |> put_html_layout({Reverso.Web.LayoutView, "email.html"})
    |> subject("REVERSO.co - Password Reset")
    |> assign(:password_reset_adress, Reverso.Web.AccountController.generate_password_reset_url(user))
    |> render("password_reset_email.html")
  end

  defp invitation_email(%User{} = user) do
    new_email()
    |> to(user.email)
    |> from("noreply@reverso.co")
    |> put_html_layout({Reverso.Web.LayoutView, "email.html"})
    |> subject("REVERSO.co - User Invitation")
    |> assign(:invitation_adress, Reverso.Web.CollaboratorController.generate_invitation_url(user))
    |> render("invitation_email.html")
  end
end
