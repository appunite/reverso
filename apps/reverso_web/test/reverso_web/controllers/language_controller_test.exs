defmodule Reverso.Web.LanguageControllerTest do
  use Reverso.Web.ConnCase

  alias Reverso.Projects
  alias Reverso.Projects.Language

  @create_attrs %{language_name: "some language_name"}
  @update_attrs %{language_name: "some updated language_name"}
  @invalid_attrs %{language_name: nil}

  def fixture(:language) do
    {:ok, language} = Projects.create_language(@create_attrs)
    language
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, language_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "creates language and renders language when data is valid", %{conn: conn} do
    conn = post conn, language_path(conn, :create), language: @create_attrs
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get conn, language_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "language_name" => "some language_name"}
  end

  test "does not create language and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, language_path(conn, :create), language: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen language and renders language when data is valid", %{conn: conn} do
    %Language{id: id} = language = fixture(:language)
    conn = put conn, language_path(conn, :update, language), language: @update_attrs
    assert %{"id" => ^id} = json_response(conn, 200)["data"]

    conn = get conn, language_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "language_name" => "some updated language_name"}
  end

  test "does not update chosen language and renders errors when data is invalid", %{conn: conn} do
    language = fixture(:language)
    conn = put conn, language_path(conn, :update, language), language: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen language", %{conn: conn} do
    language = fixture(:language)
    conn = delete conn, language_path(conn, :delete, language)
    assert response(conn, 204)
    assert_error_sent 404, fn ->
      get conn, language_path(conn, :show, language)
    end
  end
end
