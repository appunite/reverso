defmodule Reverso.Web.LanguageController do
  use Reverso.Web, :controller

  alias Reverso.Projects

  def index(conn, _params) do
    languages = Projects.list_languages()
    render(conn, "index.html", languages: languages)
  end

  def new(conn, _params) do
    changeset = Projects.change_language(%Reverso.Projects.Language{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"language" => language_params}) do
    case Projects.create_language(language_params) do
      {:ok, language} ->
        conn
        |> put_flash(:info, "Language created successfully.")
        |> redirect(to: language_path(conn, :show, language))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    language = Projects.get_language!(id)
    render(conn, "show.html", language: language)
  end

  def edit(conn, %{"id" => id}) do
    language = Projects.get_language!(id)
    changeset = Projects.change_language(language)
    render(conn, "edit.html", language: language, changeset: changeset)
  end

  def update(conn, %{"id" => id, "language" => language_params}) do
    language = Projects.get_language!(id)

    case Projects.update_language(language, language_params) do
      {:ok, language} ->
        conn
        |> put_flash(:info, "Language updated successfully.")
        |> redirect(to: language_path(conn, :show, language))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", language: language, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    language = Projects.get_language!(id)
    {:ok, _language} = Projects.delete_language(language)

    conn
    |> put_flash(:info, "Language deleted successfully.")
    |> redirect(to: language_path(conn, :index))
  end
end
