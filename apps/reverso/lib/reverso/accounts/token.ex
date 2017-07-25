defmodule Reverso.Accounts.Token do
  alias Reverso.Accounts.User
  
  def generate_activation_url(%User{} = user) do
    Reverso.Web.Router.Helpers.token_url(Reverso.Web.Endpoint,
      :activate_account,
      token: user.activation_token)
  end

  def generate_password_reset_url(%User{} = user) do
    Reverso.Web.Router.Helpers.token_url(Reverso.Web.Endpoint,
      :password_reset,
      token: user.password_reset_token)
  end
end
