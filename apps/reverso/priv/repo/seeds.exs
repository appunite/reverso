# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Reverso.Repo.insert!(%Reverso.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
Reverso.Accounts.create_user(
      %{email: "foo@bar.com",
        name: "foobar",
        password: "12345",
        password_confirmation: "12345",
        activation_token: "activate"})
Reverso.Accounts.create_user(
  %{email: "example@example.com",
    name: "example",
    password: "12345",
    password_confirmation: "12345",
    activation_token: Ecto.UUID.generate()})
Reverso.Accounts.create_user(
  %{email: "lubie@placki.com",
    name: "lubieplatzky",
    password: "12345",
    password_confirmation: "12345",
    activation_token: Ecto.UUID.generate()})
Reverso.Accounts.activate("activate")
