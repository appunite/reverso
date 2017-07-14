defmodule Reverso.Web.Plugs.Authenticate do
  import Plug.Conn

  def init(_), do: []

  def call(conn, _opts) do
    with token <- get_req_header(conn, "authorization"),
         {:ok, user} <- Reverso.Accounts.fetch_by_token(token) do
          conn
          |> assign(:current_user, user)
          |> assign(:current_user_id, user.id)
    else
      _ ->
        conn
        |> put_status(:unauthorized)
        |> Phoenix.Controller.render(Web.ErrorView, "401.json")
        |> halt()
    end
  end
end