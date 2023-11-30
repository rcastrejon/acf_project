defmodule AcfProjectWeb.AlumnoJSON do
  alias AcfProject.SICEI.Alumno

  @doc """
  Renders a list of alumnos.
  """
  def index(%{alumnos: alumnos}) do
    %{data: for(alumno <- alumnos, do: data(alumno))}
  end

  @doc """
  Renders a single alumno.
  """
  def show(%{alumno: alumno}) do
    data(alumno)
  end

  defp data(%Alumno{} = alumno) do
    %{
      id: alumno.id,
      nombres: alumno.nombres,
      apellidos: alumno.apellidos,
      matricula: alumno.matricula,
      promedio: alumno.promedio,
      fotoPerfilUrl: alumno.foto_perfil_url
    }
  end
end
