defmodule Reverso.Web.TranslationController do
  use Reverso.Web, :controller

  alias Reverso.Projects

  def index(conn, _params) do
    translations = Projects.list_translations()
    render(conn, "index.html", translations: translations)
  end

  def new(conn, _params) do
    changeset = Projects.change_translation(%Reverso.Projects.Translation{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"translation" => translation_params}) do
    case Projects.create_translation(translation_params) do
      {:ok, translation} ->
        conn
        |> put_flash(:info, "Translation created successfully.")
        |> redirect(to: translation_path(conn, :show, translation))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    translation = Projects.get_translation!(id)
    render(conn, "show.html", translation: translation)
  end

  def edit(conn, %{"id" => id}) do
    translation = Projects.get_translation!(id)
    changeset = Projects.change_translation(translation)
    render(conn, "edit.html", translation: translation, changeset: changeset)
  end

  def update(conn, %{"id" => id, "translation" => translation_params}) do
    translation = Projects.get_translation!(id)

    case Projects.update_translation(translation, translation_params) do
      {:ok, translation} ->
        conn
        |> put_flash(:info, "Translation updated successfully.")
        |> redirect(to: translation_path(conn, :show, translation))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", translation: translation, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    translation = Projects.get_translation!(id)
    {:ok, _translation} = Projects.delete_translation(translation)

    conn
    |> put_flash(:info, "Translation deleted successfully.")
    |> redirect(to: translation_path(conn, :index))
  end
end
