defmodule Reverso.Application do
  @moduledoc """
  The Reverso Application Service.

  The reverso system business domain lives in this application.

  Exposes API to clients such as the `Reverso.Web` application
  for use in channels, controllers, and elsewhere.
  """
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    Supervisor.start_link([
      supervisor(Reverso.Repo, []),
    ], strategy: :one_for_one, name: Reverso.Supervisor)
  end
end
