defmodule AcfProjectWeb.Router do
  use AcfProjectWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", AcfProjectWeb do
    pipe_through :api

    resources "/alumnos", AlumnoController
    post "/alumnos/:id/email", AlumnoController, :send_email
    post "/alumnos/:id/fotoPerfil", AlumnoController, :upload_profile_picture

    post "/alumnos/:alumno_id/session/login", SessionController, :create
    post "/alumnos/:alumno_id/session/verify", SessionController, :show
    post "/alumnos/:alumno_id/session/logout", SessionController, :delete

    resources "/profesores", ProfesorController

    # Method not allowed. This is necessary to pass the assignment's tests.
    [&get/3, &post/3, &put/3, &patch/3, &delete/3, &options/3, &connect/3, &trace/3, &head/3]
    |> Enum.each(fn verb -> verb.("/*path", MethodNotAllowedController, :match) end)
  end
end
