defmodule AcfProjectWeb.ProfesorController do
  use AcfProjectWeb, :controller

  alias AcfProject.SICEI
  alias AcfProject.SICEI.Profesor

  action_fallback AcfProjectWeb.FallbackController

  def index(conn, _params) do
    profesores = SICEI.list_profesores()
    render(conn, :index, profesores: profesores)
  end

  def create(conn, %{} = profesor_params) do
    with {:ok, %Profesor{} = profesor} <- SICEI.create_profesor(profesor_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/profesores/#{profesor}")
      |> render(:show, profesor: profesor)
    end
  end

  def show(conn, %{"id" => id}) do
    profesor = SICEI.get_profesor!(id)
    render(conn, :show, profesor: profesor)
  end

  def update(conn, %{"id" => id} = profesor_params) do
    profesor = SICEI.get_profesor!(id)

    with {:ok, %Profesor{} = profesor} <- SICEI.update_profesor(profesor, profesor_params) do
      render(conn, :show, profesor: profesor)
    end
  end

  def delete(conn, %{"id" => id}) do
    profesor = SICEI.get_profesor!(id)

    with {:ok, %Profesor{}} <- SICEI.delete_profesor(profesor) do
      send_resp(conn, :ok, "")
    end
  end
end
