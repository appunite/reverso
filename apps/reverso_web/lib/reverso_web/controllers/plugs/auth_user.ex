defmodule Reverso.Web.Plugs.AuthUser do
  import Plug.Conn
  alias Reverso.Accounts

  def init(_), do: []

  def call(conn, _opts) do
    with [token] <- get_req_header(conn, "authorization"),
         {:ok, user} <- Accounts.fetch_by_user_token(token) do
          conn
          |> assign(:current_user, user)
          |> assign(:current_user_id, user.id)
    else
      _ ->
        conn
        |> put_status(:unauthorized)
        |> Phoenix.Controller.render(Reverso.Web.ErrorView, "401.json")
        |> halt()
    end
  end
end
