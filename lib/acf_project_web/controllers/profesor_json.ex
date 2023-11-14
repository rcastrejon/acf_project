defmodule AcfProjectWeb.ProfesorJSON do
  alias AcfProject.SICEI.Profesor

  @doc """
  Renders a list of profesores.
  """
  def index(%{profesores: profesores}) do
    %{data: for(profesor <- profesores, do: data(profesor))}
  end

  @doc """
  Renders a single profesor.
  """
  def show(%{profesor: profesor}) do
    data(profesor)
  end

  defp data(%Profesor{} = profesor) do
    %{
      id: profesor.id,
      numeroEmpleado: profesor.numeroEmpleado,
      nombres: profesor.nombres,
      apellidos: profesor.apellidos,
      horasClase: profesor.horasClase
    }
  end
end
