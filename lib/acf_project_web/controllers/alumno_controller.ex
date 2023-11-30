defmodule AcfProjectWeb.AlumnoController do
  use AcfProjectWeb, :controller

  alias AcfProject.ProfilePicture
  alias AcfProject.SICEI
  alias AcfProject.SICEI.Alumno

  action_fallback AcfProjectWeb.FallbackController

  def index(conn, _params) do
    alumnos = SICEI.list_alumnos()
    render(conn, :index, alumnos: alumnos)
  end

  def create(conn, %{} = alumno_params) do
    with {:ok, %Alumno{} = alumno} <- SICEI.create_alumno(alumno_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/alumnos/#{alumno}")
      |> render(:show, alumno: alumno)
    end
  end

  def show(conn, %{"id" => id}) do
    alumno = SICEI.get_alumno!(id)
    render(conn, :show, alumno: alumno)
  end

  def update(conn, %{"id" => id} = alumno_params) do
    alumno = SICEI.get_alumno!(id)

    with {:ok, %Alumno{} = alumno} <- SICEI.update_alumno(alumno, alumno_params) do
      render(conn, :show, alumno: alumno)
    end
  end

  def delete(conn, %{"id" => id}) do
    alumno = SICEI.get_alumno!(id)

    with {:ok, %Alumno{}} <- SICEI.delete_alumno(alumno) do
      send_resp(conn, :ok, "")
    end
  end

  def upload_profile_picture(conn, %{"id" => id, "foto" => profile_picture}) do
    alumno = SICEI.get_alumno!(id)

    with {:ok, filename} <- ProfilePicture.store({profile_picture, alumno}),
         url <- ProfilePicture.url({filename, alumno}),
         {:ok, %Alumno{} = alumno} <- SICEI.update_alumno_profile_picture_url(alumno, url) do
      render(conn, :show, alumno: alumno)
    end
  end
end
