defmodule Extrakt do
  def start(port) do
    routes = Extrakt.Router.routes()

    dispatch_rules =
      :cowboy_router.compile(routes)

    {:ok, _pid} =
      :cowboy.start_clear(
        :listener,
        [{:port, port}],
        %{env: %{dispatch: dispatch_rules}}
      )
  end
end
