# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
#     mix run apps/reverso/priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Reverso.Repo.insert!(%Reverso.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

# USER 1 activated
Reverso.Accounts.create_user(
      %{"email" => "foo@bar.com",
        "name" => "foobar",
        "password" => "12345",
        "password_confirmation" => "12345",
        "activation_token" => "activate"})
#Reverso.Accounts.activate("activate")

# USER 2 activated
Reverso.Accounts.create_user(
      %{"email" => "mike@schabowy.com",
        "name" => "mike",
        "password" => "12345",
        "password_confirmation" => "12345",
        "activation_token" => "activate_mike"})
#Reverso.Accounts.activate("activate_mike")

#USER 3 and 4 not activated 
Reverso.Accounts.create_user(
  %{"email" => "example@example.com",
    "name" => "example",
    "password" => "12345",
    "password_confirmation" => "12345",
    "activation_token" => Ecto.UUID.generate()})

Reverso.Accounts.create_user(
  %{"email" => "lubie@placki.com",
    "name" => "lubieplatzky",
    "password" => "12345",
    "password_confirmation" => "12345",
    "activation_token" => Ecto.UUID.generate()})

Reverso.Projects.create_project(
  %{project_name: "Kiszone Ogorki",
    basic_language: "English",
    basic_language_id: 1,
    owner_id: 1}, ["iOS", "Android"])

Reverso.Projects.create_project(
  %{project_name: "Frytki z Octem",
    basic_language: "Spanish",
    basic_language_id: 2,
    owner_id: 1}, ["Desktop"])

Reverso.Projects.create_project(
  %{project_name: "Pomalowane Aluminum",
    basic_language: "German",
    basic_language_id: 3,
    owner_id: 1}, ["Android"])

Reverso.Projects.create_project(
  %{project_name: "Ciastko z Niespodzianka",
    basic_language: "English",
    basic_language_id: 4,
    owner_id: 2}, ["Android", "iOS"])

Reverso.Projects.create_project(
  %{project_name: "Baba z Radomia",
    basic_language: "Russian",
    basic_language_id: 5,
    owner_id: 2}, ["Desktop", "iOS"])

Reverso.Repo.insert(%Reverso.Projects.Language{language_name: "Spanish", project_id: 1 })
Reverso.Repo.insert(%Reverso.Projects.Language{language_name: "Japanese", project_id: 1 })
Reverso.Repo.insert(%Reverso.Projects.Language{language_name: "English", project_id: 2 })
Reverso.Repo.insert(%Reverso.Projects.Language{language_name: "German", project_id: 4 })
Reverso.Repo.insert(%Reverso.Projects.Language{language_name: "English", project_id: 5 })





