defmodule Reverso.Web.FileController do
  use Reverso.Web, :controller

  def export_file(conn, _params) do
    conn
    |> put_resp_content_type("text/xml")
    |> put_resp_header("content-disposition", "attachment; filename=\"xliff.xlf\"")
    |> send_resp(200, Reverso.File.content)
  end
end
