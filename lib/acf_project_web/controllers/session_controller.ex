defmodule AcfProjectWeb.SessionController do
  alias AcfProject.SICEI.Alumno
  alias AcfProject.SICEI
  use AcfProjectWeb, :controller

  action_fallback AcfProjectWeb.FallbackController

  def create(conn, %{"alumno_id" => alumno_id, "password" => password}) do
    with %Alumno{} = alumno <- SICEI.get_alumno_by_id_and_password(alumno_id, password),
         {:ok, session} <- SICEI.generate_alumno_session(alumno) do
      render(conn, :show, session: session)
    else
      _ ->
        conn
        |> put_status(400)
        |> put_view(AcfProjectWeb.ErrorJSON)
        |> render("400.json")
    end
  end

  def show(conn, %{"alumno_id" => _alumno_id, "sessionString" => session_string}) do
    with {:ok, session} <- SICEI.verify_alumno_session(session_string) do
      render(conn, :show, session: session)
    else
      _ ->
        conn
        |> put_status(400)
        |> put_view(AcfProjectWeb.ErrorJSON)
        |> render("400.json")
    end
  end

  def delete(conn, %{"alumno_id" => alumno_id, "sessionString" => session_string}) do
    alumno = SICEI.get_alumno!(alumno_id)

    with {:ok, _} <- SICEI.expire_alumno_session(session_string) do
      conn
      |> put_view(AcfProjectWeb.AlumnoJSON)
      |> render(:show, alumno: alumno)
    end
  end
end
