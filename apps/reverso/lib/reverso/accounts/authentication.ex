defmodule Reverso.Accounts.Authentication do

  import Ecto.Query, warn: false
  alias Reverso.Accounts.User

  def authenticate(%User{} = user, password) do
    case Comeonin.Bcrypt.checkpw(password, user.crypted_password) do
      true -> {:ok, :auth_ok}
      _ -> {:error, :auth_error}
    end
  end

  def authenticate(_, _) do
    Comeonin.Bcrypt.dummy_checkpw()
    {:error, :auth_error}
  end
end
