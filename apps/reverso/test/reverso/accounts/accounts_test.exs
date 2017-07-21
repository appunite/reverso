defmodule Reverso.AccountsTest do
  use Reverso.DataCase

  alias Reverso.Accounts

  describe "users" do
    alias Reverso.Accounts.User



    @valid_attrs %{
      email: "some@email.com",
      password: "some password",
      password_confirmation: "some password",
      username: "some username"}

    @update_attrs %{
      email: "some@updatedemail.com",
      password: "some updated password",
      password_confirmation: "some updated password",
      username: "some updated username"}

    @invalid_attrs %{
      email: nil,
      password: nil,
      password_confirmation: nil,
      username: nil}


    def valid_user() do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = valid_user()
      assert Accounts.list_users() == [user]
    end

    test "fetch_by_id/1 returns the user with given id" do
      user = valid_user()
      assert Accounts.fetch_by_id(user.id) == {:ok, user}
    end

    test "fetch_by_email/1 returns the user with given id" do
      user = valid_user()
      assert Accounts.fetch_by_email(user.email) == {:ok, user}
    end

    test "fetch_by_id/1 error test" do
      invalid_id = 90
      assert Accounts.fetch_by_id(invalid_id) == {:error, :user_not_found}
    end

    test "fetch_by_email/1 error test" do
      invalid_email = "invalid@email.com"
      assert Accounts.fetch_by_email(invalid_email) == {:error, :user_not_found}
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.email == "some@email.com"
      assert user.password == "some password"
      assert user.username == "some username"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, user} = Accounts.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.email == "some updated email"
      assert user.username == "some updated username"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert {:ok, user} == Accounts.fetch_by_id(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.fetch_by_id(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end


  end
end
