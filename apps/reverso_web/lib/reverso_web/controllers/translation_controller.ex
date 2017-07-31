defmodule Reverso.Web.TranslationController do
  use Reverso.Web, :controller

  alias Reverso.Projects
  alias Reverso.Projects.Translation

  action_fallback Reverso.Web.FallbackController

  def index(conn, %{"project_id" => project_id, "language_id" => language_id}) do
    translations = Projects.get_translation_for_project(project_id,language_id)
    render(conn, "index.json", translations: translations)
  end

  def create(conn, %{"translation" => params, "file" => file}) do
    with {:ok, %Translation{} = translation} <- 
      Projects.create_translation(params,file, conn.assigns.current_user_id) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", translation_path(conn, :show, translation))
      |> render("show.json", translation: translation)
    end
  end

  def show(conn, %{"id" => id}) do
    translation = Projects.get_translation!(id)
    render(conn, "show.json", translation: translation)
  end

  def update(conn, %{"id" => id, "translation" => translation_params}) do
    translation = Projects.get_translation!(id)

    with {:ok, %Translation{} = translation} <- Projects.update_translation(translation, translation_params) do
      render(conn, "show.json", translation: translation)
    end
  end

  def delete(conn, %{"id" => id}) do
    translation = Projects.get_translation!(id)
    with {:ok, %Translation{}} <- Projects.delete_translation(translation) do
      send_resp(conn, :no_content, "")
    end
  end
end
