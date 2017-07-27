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
    owner_id: 1}, ["iOS", "Android"])

Reverso.Projects.create_project(
  %{project_name: "Frytki z Octem",
    basic_language: "Spanish",
    owner_id: 1}, ["Desktop"])

Reverso.Projects.create_project(
  %{project_name: "Pomalowane Aluminum",
    basic_language: "Nihali",
    owner_id: 1}, ["Android"])

Reverso.Projects.create_project(
  %{project_name: "Ciastko z Niespodzianka",
    basic_language: "Burushian",
    owner_id: 2}, ["Android", "iOS"])

Reverso.Projects.create_project(
  %{project_name: "Baba z Radomia",
    basic_language: "Sandawe",
    owner_id: 2}, ["Desktop", "iOS"])

Reverso.Repo.insert(%Reverso.Projects.Language{language_name: "Spanish", project_id: 1 })
Reverso.Repo.insert(%Reverso.Projects.Language{language_name: "Japanese", project_id: 1 })
Reverso.Repo.insert(%Reverso.Projects.Language{language_name: "German", project_id: 1 })
Reverso.Repo.insert(%Reverso.Projects.Language{language_name: "English", project_id: 2 })
Reverso.Repo.insert(%Reverso.Projects.Language{language_name: "Polish", project_id: 2 })
Reverso.Repo.insert(%Reverso.Projects.Language{language_name: "Spanish", project_id: 3 })
Reverso.Repo.insert(%Reverso.Projects.Language{language_name: "German", project_id: 4 })
Reverso.Repo.insert(%Reverso.Projects.Language{language_name: "English", project_id: 4 })
Reverso.Repo.insert(%Reverso.Projects.Language{language_name: "English", project_id: 5 })
Reverso.Repo.insert(%Reverso.Projects.Language{language_name: "Russian", project_id: 5 })

Reverso.Repo.insert(%Reverso.Projects.Translation{
  basic: "You miss 100% of the shots you don’t take.",
  translation: "撮影していないショットの100％が欠場します。",
  language_id: 2,
  platform_id: 1,
  platform_key: "14",
  project_id: 1,
  user_id: 1
})

Reverso.Repo.insert(%Reverso.Projects.Translation{
  basic: "Always bear in mind that your own resolution to succeed is more important than any other.",
  translation: "成功するための自分の決断は、他のものよりも重要であることに常に留意してください。",
  language_id: 2,
  platform_id: 1,
  platform_key: "114",
  project_id: 1,
  user_id: 1
})

Reverso.Repo.insert(%Reverso.Projects.Translation{
  basic: "Be the change you want to see in the world",
  translation: "あなたが世界で見たいと思う変化である",
  language_id: 2,
  platform_id: 2,
  platform_key: "smieszny",
  project_id: 1,
  user_id: 2
})

Reverso.Repo.insert(%Reverso.Projects.Translation{
  basic: "Before you marry, look what you are doing.",
  translation: "Antes que te cases, mira lo que haces.",
  language_id: 1,
  platform_id: 1,
  platform_key: "Pierwszy espanol",
  project_id: 1,
  user_id: 1
})

Reverso.Repo.insert(%Reverso.Projects.Translation{
  basic: "In a hundred years we will be dead anyway.",
  translation: "Despues de los años mil, Torna el agua a su carril.",
  language_id: 1,
  platform_id: 1,
  platform_key: "Drugi espanol",
  project_id: 1,
  user_id: 2
})

Reverso.Repo.insert(%Reverso.Projects.Translation{
  basic: "Antes que te cases, mira lo que haces.",
  translation: "Before you marry, look what you are doing.",
  language_id: 3,
  platform_id: 3,
  platform_key: "Pierwszy english",
  project_id: 2,
  user_id: 1
})

Reverso.Repo.insert(%Reverso.Projects.Translation{
  basic: "In a hundred years we will be dead anyway.",
  translation: "Despues de los años mil, Torna el agua a su carril.",
  language_id: 3,
  platform_id: 3,
  platform_key: "Drugi espanol",
  project_id: 2,
  user_id: 2
})




