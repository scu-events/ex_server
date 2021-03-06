defmodule ExServer.Application do
  @moduledoc """
  The ExServer Application Service.

  The ex_server system business domain lives in this application.

  Exposes API to clients such as the `ExServerWeb` application
  for use in channels, controllers, and elsewhere.
  """
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    Supervisor.start_link([
      supervisor(ExServer.Repo, []),
    ], strategy: :one_for_one, name: ExServer.Supervisor)
  end
end
