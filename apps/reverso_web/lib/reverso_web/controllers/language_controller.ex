defmodule Reverso.Web.LanguageController do
  use Reverso.Web, :controller

  alias Reverso.Projects
  alias Reverso.Projects.Language

  action_fallback Reverso.Web.FallbackController

  def index(conn, %{"id"=> project_id}) do
    languages= Projects.get_languages_by_project(String.to_integer(project_id))
    render(conn, "index.json", language: languages)
  end

  def create(conn, %{"language" => language_params}) do
    with {:ok, %Language{} = language} <- Projects.create_language(language_params) do
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
