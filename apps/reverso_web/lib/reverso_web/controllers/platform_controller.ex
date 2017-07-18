defmodule Reverso.Web.PlatformController do
  use Reverso.Web, :controller

  alias Reverso.Projects
  alias Reverso.Projects.Platform

  action_fallback Reverso.Web.FallbackController

  def index(conn, _params) do
    platforms = Projects.list_platforms()
    render(conn, "index.json", platforms: platforms)
  end

  def create(conn, %{"platform" => platform_params}) do
    with {:ok, %Platform{} = platform} <- Projects.create_platform(platform_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", platform_path(conn, :show, platform))
      |> render("show.json", platform: platform)
    end
  end

  def show(conn, %{"id" => id}) do
    platform = Projects.get_platform!(id)
    render(conn, "show.json", platform: platform)
  end

  def update(conn, %{"id" => id, "platform" => platform_params}) do
    platform = Projects.get_platform!(id)

    with {:ok, %Platform{} = platform} <- Projects.update_platform(platform, platform_params) do
      render(conn, "show.json", platform: platform)
    end
  end

  def delete(conn, %{"id" => id}) do
    platform = Projects.get_platform!(id)
    with {:ok, %Platform{}} <- Projects.delete_platform(platform) do
      send_resp(conn, :no_content, "")
    end
  end
end
