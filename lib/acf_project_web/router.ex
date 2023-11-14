defmodule AcfProjectWeb.Router do
  use AcfProjectWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", AcfProjectWeb do
    pipe_through :api
  end
end
