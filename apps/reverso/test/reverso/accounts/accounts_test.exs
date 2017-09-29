defmodule Reverso.AccountsTest do
  use Reverso.DataCase

  alias Reverso.Accounts

  describe "users" do
    alias Reverso.Accounts.User

    @valid_attrs %{
      email: "some@email.com",
      password: "some password",
      password_confirmation: "some password",
      name: "some username"}

    @update_attrs %{
      email: "some@updatedemail.com",
      password: "some updated password",
      password_confirmation: "some updated password",
      name: "some updated username"}

    @invalid_attrs %{
      email: nil,
      password: nil,
      password_confirmation: nil,
      name: nil}

    def valid_user(params \\ %{}) do
      {:ok, user} =
        Enum.into(params, @valid_attrs)
        |> Accounts.create_user()

      %{user | password: ""}
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
      assert user.name == "some username"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = valid_user()
      assert {:ok, user} = Accounts.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.email == "some@updatedemail.com"
      assert user.name == "some updated username"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = valid_user()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert {:ok, user} == Accounts.fetch_by_id(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = valid_user()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert {:error, :user_not_found} == Accounts.fetch_by_id(user.id)
    end

    test "change_user/1 returns a user changeset" do
      user = valid_user()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end


  end
end
