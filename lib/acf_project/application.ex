defmodule AcfProject.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      AcfProjectWeb.Telemetry,
      # Start the Ecto repository
      # AcfProject.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: AcfProject.PubSub},
      # Start the Endpoint (http/https)
      AcfProjectWeb.Endpoint
      # Start a worker by calling: AcfProject.Worker.start_link(arg)
      # {AcfProject.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: AcfProject.Supervisor]
    :ets.new(AcfProject.SICEI.Alumno, [:set, :public, :named_table])
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    AcfProjectWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
