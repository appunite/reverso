defmodule Reverso.Web.LanguageController do
  use Reverso.Web, :controller
 
  alias Reverso.Projects
  alias Reverso.Projects.Language

  action_fallback Reverso.Web.FallbackController

  def index(conn, _params) do
    languages= Projects.list_languages()
    render(conn, "index.json", languages: languages)
  end

  def create(conn,%{
    "language_file" => language_file,
    "language_name" => language_name,
    "project_id" => project_id,
    "platforms" => platforms}) do
    language_params = %{language_name: language_name, project_id: project_id}
    with {:ok, [language]} <- 
      Projects.create_language(language_params, language_file.path, conn.assigns.current_user_id, platforms) do
      conn
      |> put_status(200)
      |> render("language_list.json", language: language)
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
