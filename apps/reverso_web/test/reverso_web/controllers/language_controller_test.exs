defmodule Reverso.Web.LanguageControllerTest do
  use Reverso.Web.ConnCase

  alias Reverso.Projects

  @create_attrs %{language: "some language"}
  @update_attrs %{language: "some updated language"}
  @invalid_attrs %{language: nil}

  def fixture(:language) do
    {:ok, language} = Projects.create_language(@create_attrs)
    language
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, language_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing Languages"
  end

  test "renders form for new languages", %{conn: conn} do
    conn = get conn, language_path(conn, :new)
    assert html_response(conn, 200) =~ "New Language"
  end

  test "creates language and redirects to show when data is valid", %{conn: conn} do
    conn = post conn, language_path(conn, :create), language: @create_attrs

    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == language_path(conn, :show, id)

    conn = get conn, language_path(conn, :show, id)
    assert html_response(conn, 200) =~ "Show Language"
  end

  test "does not create language and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, language_path(conn, :create), language: @invalid_attrs
    assert html_response(conn, 200) =~ "New Language"
  end

  test "renders form for editing chosen language", %{conn: conn} do
    language = fixture(:language)
    conn = get conn, language_path(conn, :edit, language)
    assert html_response(conn, 200) =~ "Edit Language"
  end

  test "updates chosen language and redirects when data is valid", %{conn: conn} do
    language = fixture(:language)
    conn = put conn, language_path(conn, :update, language), language: @update_attrs
    assert redirected_to(conn) == language_path(conn, :show, language)

    conn = get conn, language_path(conn, :show, language)
    assert html_response(conn, 200) =~ "some updated language"
  end

  test "does not update chosen language and renders errors when data is invalid", %{conn: conn} do
    language = fixture(:language)
    conn = put conn, language_path(conn, :update, language), language: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit Language"
  end

  test "deletes chosen language", %{conn: conn} do
    language = fixture(:language)
    conn = delete conn, language_path(conn, :delete, language)
    assert redirected_to(conn) == language_path(conn, :index)
    assert_error_sent 404, fn ->
      get conn, language_path(conn, :show, language)
    end
  end
end
