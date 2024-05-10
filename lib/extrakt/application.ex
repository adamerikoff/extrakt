defmodule Extrakt.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Add this line
      {Task, fn -> Extrakt.Server.start(4040) end}
    ]

    opts = [
      strategy: :one_on_one,
      name: Extrakt.Supervisor
    ]

    Supervisor.start_link(children, opts)
  end


end
