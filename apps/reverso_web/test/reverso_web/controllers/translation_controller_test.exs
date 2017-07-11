defmodule Reverso.Web.TranslationControllerTest do
  use Reverso.Web.ConnCase

  alias Reverso.Projects

  @create_attrs %{basic: "some basic", translation: "some translation"}
  @update_attrs %{basic: "some updated basic", translation: "some updated translation"}
  @invalid_attrs %{basic: nil, translation: nil}

  def fixture(:translation) do
    {:ok, translation} = Projects.create_translation(@create_attrs)
    translation
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, translation_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing Translations"
  end

  test "renders form for new translations", %{conn: conn} do
    conn = get conn, translation_path(conn, :new)
    assert html_response(conn, 200) =~ "New Translation"
  end

  test "creates translation and redirects to show when data is valid", %{conn: conn} do
    conn = post conn, translation_path(conn, :create), translation: @create_attrs

    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == translation_path(conn, :show, id)

    conn = get conn, translation_path(conn, :show, id)
    assert html_response(conn, 200) =~ "Show Translation"
  end

  test "does not create translation and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, translation_path(conn, :create), translation: @invalid_attrs
    assert html_response(conn, 200) =~ "New Translation"
  end

  test "renders form for editing chosen translation", %{conn: conn} do
    translation = fixture(:translation)
    conn = get conn, translation_path(conn, :edit, translation)
    assert html_response(conn, 200) =~ "Edit Translation"
  end

  test "updates chosen translation and redirects when data is valid", %{conn: conn} do
    translation = fixture(:translation)
    conn = put conn, translation_path(conn, :update, translation), translation: @update_attrs
    assert redirected_to(conn) == translation_path(conn, :show, translation)

    conn = get conn, translation_path(conn, :show, translation)
    assert html_response(conn, 200) =~ "some updated basic"
  end

  test "does not update chosen translation and renders errors when data is invalid", %{conn: conn} do
    translation = fixture(:translation)
    conn = put conn, translation_path(conn, :update, translation), translation: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit Translation"
  end

  test "deletes chosen translation", %{conn: conn} do
    translation = fixture(:translation)
    conn = delete conn, translation_path(conn, :delete, translation)
    assert redirected_to(conn) == translation_path(conn, :index)
    assert_error_sent 404, fn ->
      get conn, translation_path(conn, :show, translation)
    end
  end
end
