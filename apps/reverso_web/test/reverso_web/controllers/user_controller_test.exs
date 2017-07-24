defmodule Reverso.Web.UserControllerTest do
  use Reverso.Web.ConnCase

  alias Reverso.Accounts
  alias Reverso.Web.UserController


  @create_attrs %{
    email: "some@email.com",
    password: "some password",
    password_confirmation: "some password",
    username: "some username"}

  @update_attrs %{
    email: "some@updatedemail.com",
    password: "some updated password",
    password_confirmation: "some updated password",
    username: "some updated username"}

  @invalid_attrs %{email: nil, password: nil, username: nil}


  describe "users" do
    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end
  end
end
