defmodule AcfProject.Repo do
  use Ecto.Repo,
    otp_app: :acf_project,
    adapter: Ecto.Adapters.Postgres
end
