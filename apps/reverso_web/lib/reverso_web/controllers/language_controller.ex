defmodule Reverso.Web.LanguageController do
  use Reverso.Web, :controller
 
  alias Reverso.Projects
  alias Reverso.Projects.Language

  action_fallback Reverso.Web.FallbackController

  def index(conn, _params) do
    languages= Projects.list_languages()
    render(conn, "index.json", languages: languages)
  end

  def list(conn, %{"id"=> project_id}) do
    languages= Projects.get_project_language_properties(String.to_integer(project_id))
    render(conn, "list.json", languages: languages)
  end

  def create(conn,%{"language_name" => name, "project_id" => id, "language_file" => file,"platforms" => platforms}) do
    language_params = %{language_name: name, project_id: id}
    with {:ok, %Language{} = language} <- 
      Projects.create_language(language_params, file, conn.assigns[:current_user_id], platforms) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", language_path(conn, :show, language))
      |> render("show.json", language: language)
    end
  end

  def show(conn, %{"id" => id}) do
    language = Projects.get_language!(id)
    render(conn, "show.json", language: language)
  end

  def update(conn, %{"id" => id, "language" => language_params}) do
    language = Projects.get_language!(id)

    with {:ok, %Language{} = language} <- Projects.update_language(language, language_params) do
      render(conn, "show.json", language: language)
    end
  end

  def delete(conn, %{"id" => id}) do
    language = Projects.get_language!(id)
    with {:ok, %Language{}} <- Projects.delete_language(language) do
      send_resp(conn, :no_content, "")
    end
  end
end
