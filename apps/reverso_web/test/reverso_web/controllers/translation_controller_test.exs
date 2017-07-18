defmodule Reverso.Web.TranslationControllerTest do
  use Reverso.Web.ConnCase

  alias Reverso.Projects
  alias Reverso.Projects.Translation

  @create_attrs %{basic: "some basic", platform_key: "some platform_key", translation: "some translation"}
  @update_attrs %{basic: "some updated basic", platform_key: "some updated platform_key", translation: "some updated translation"}
  @invalid_attrs %{basic: nil, platform_key: nil, translation: nil}

  def fixture(:translation) do
    {:ok, translation} = Projects.create_translation(@create_attrs)
    translation
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, translation_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "creates translation and renders translation when data is valid", %{conn: conn} do
    conn = post conn, translation_path(conn, :create), translation: @create_attrs
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get conn, translation_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "basic" => "some basic",
      "platform_key" => "some platform_key",
      "translation" => "some translation"}
  end

  test "does not create translation and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, translation_path(conn, :create), translation: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen translation and renders translation when data is valid", %{conn: conn} do
    %Translation{id: id} = translation = fixture(:translation)
    conn = put conn, translation_path(conn, :update, translation), translation: @update_attrs
    assert %{"id" => ^id} = json_response(conn, 200)["data"]

    conn = get conn, translation_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "basic" => "some updated basic",
      "platform_key" => "some updated platform_key",
      "translation" => "some updated translation"}
  end

  test "does not update chosen translation and renders errors when data is invalid", %{conn: conn} do
    translation = fixture(:translation)
    conn = put conn, translation_path(conn, :update, translation), translation: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen translation", %{conn: conn} do
    translation = fixture(:translation)
    conn = delete conn, translation_path(conn, :delete, translation)
    assert response(conn, 204)
    assert_error_sent 404, fn ->
      get conn, translation_path(conn, :show, translation)
    end
  end
end
