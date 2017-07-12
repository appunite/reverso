defmodule Reverso.Web.ProjectControllerTest do
  use Reverso.Web.ConnCase

  alias Reverso.Projects

  @create_attrs %{platform: "some platform", title: "some title"}
  @update_attrs %{platform: "some updated platform", title: "some updated title"}
  @invalid_attrs %{platform: nil, title: nil}

  def fixture(:project) do
    {:ok, project} = Projects.create_project(@create_attrs)
    project
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, project_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing Projects"
  end

  test "renders form for new projects", %{conn: conn} do
    conn = get conn, project_path(conn, :new)
    assert html_response(conn, 200) =~ "New Project"
  end

  test "creates project and redirects to show when data is valid", %{conn: conn} do
    conn = post conn, project_path(conn, :create), project: @create_attrs

    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == project_path(conn, :show, id)

    conn = get conn, project_path(conn, :show, id)
    assert html_response(conn, 200) =~ "Show Project"
  end

  test "does not create project and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, project_path(conn, :create), project: @invalid_attrs
    assert html_response(conn, 200) =~ "New Project"
  end

  test "renders form for editing chosen project", %{conn: conn} do
    project = fixture(:project)
    conn = get conn, project_path(conn, :edit, project)
    assert html_response(conn, 200) =~ "Edit Project"
  end

  test "updates chosen project and redirects when data is valid", %{conn: conn} do
    project = fixture(:project)
    conn = put conn, project_path(conn, :update, project), project: @update_attrs
    assert redirected_to(conn) == project_path(conn, :show, project)

    conn = get conn, project_path(conn, :show, project)
    assert html_response(conn, 200) =~ "some updated platform"
  end

  test "does not update chosen project and renders errors when data is invalid", %{conn: conn} do
    project = fixture(:project)
    conn = put conn, project_path(conn, :update, project), project: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit Project"
  end

  test "deletes chosen project", %{conn: conn} do
    project = fixture(:project)
    conn = delete conn, project_path(conn, :delete, project)
    assert redirected_to(conn) == project_path(conn, :index)
    assert_error_sent 404, fn ->
      get conn, project_path(conn, :show, project)
    end
  end
end
