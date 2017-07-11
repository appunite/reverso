defmodule Reverso.Web.PageController do
  use Reverso.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
