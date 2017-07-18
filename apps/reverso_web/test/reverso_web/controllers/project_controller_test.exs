defmodule Reverso.Web.ProjectControllerTest do
  use Reverso.Web.ConnCase

  alias Reverso.Projects
  alias Reverso.Projects.Project

  @create_attrs %{basic_language: "some basic_language", project_name: "some project_name"}
  @update_attrs %{basic_language: "some updated basic_language", project_name: "some updated project_name"}
  @invalid_attrs %{basic_language: nil, project_name: nil}

  def fixture(:project) do
    {:ok, project} = Projects.create_project(@create_attrs)
    project
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, project_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "creates project and renders project when data is valid", %{conn: conn} do
    conn = post conn, project_path(conn, :create), project: @create_attrs
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get conn, project_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "basic_language" => "some basic_language",
      "project_name" => "some project_name"}
  end

  test "does not create project and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, project_path(conn, :create), project: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen project and renders project when data is valid", %{conn: conn} do
    %Project{id: id} = project = fixture(:project)
    conn = put conn, project_path(conn, :update, project), project: @update_attrs
    assert %{"id" => ^id} = json_response(conn, 200)["data"]

    conn = get conn, project_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "basic_language" => "some updated basic_language",
      "project_name" => "some updated project_name"}
  end

  test "does not update chosen project and renders errors when data is invalid", %{conn: conn} do
    project = fixture(:project)
    conn = put conn, project_path(conn, :update, project), project: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen project", %{conn: conn} do
    project = fixture(:project)
    conn = delete conn, project_path(conn, :delete, project)
    assert response(conn, 204)
    assert_error_sent 404, fn ->
      get conn, project_path(conn, :show, project)
    end
  end
end
