defmodule Reverso.Web.PlatformControllerTest do
  use Reverso.Web.ConnCase

  alias Reverso.Projects
  alias Reverso.Projects.Platform

  @create_attrs %{platform_name: "some platform_name"}
  @update_attrs %{platform_name: "some updated platform_name"}
  @invalid_attrs %{platform_name: nil}

  def fixture(:platform) do
    {:ok, platform} = Projects.create_platform(@create_attrs)
    platform
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, platform_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "creates platform and renders platform when data is valid", %{conn: conn} do
    conn = post conn, platform_path(conn, :create), platform: @create_attrs
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get conn, platform_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "platform_name" => "some platform_name"}
  end

  test "does not create platform and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, platform_path(conn, :create), platform: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen platform and renders platform when data is valid", %{conn: conn} do
    %Platform{id: id} = platform = fixture(:platform)
    conn = put conn, platform_path(conn, :update, platform), platform: @update_attrs
    assert %{"id" => ^id} = json_response(conn, 200)["data"]

    conn = get conn, platform_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "platform_name" => "some updated platform_name"}
  end

  test "does not update chosen platform and renders errors when data is invalid", %{conn: conn} do
    platform = fixture(:platform)
    conn = put conn, platform_path(conn, :update, platform), platform: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen platform", %{conn: conn} do
    platform = fixture(:platform)
    conn = delete conn, platform_path(conn, :delete, platform)
    assert response(conn, 204)
    assert_error_sent 404, fn ->
      get conn, platform_path(conn, :show, platform)
    end
  end
end
