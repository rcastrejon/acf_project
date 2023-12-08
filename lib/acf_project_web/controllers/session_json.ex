defmodule AcfProjectWeb.SessionJSON do
  @doc """
  Renders a single alumno.
  """
  def show(%{session: session}) do
    data(session)
  end

  defp data(session) do
    %{
      id: session.id,
      fecha: session.fecha,
      alumnoId: session.alumno_id,
      active: session.active,
      sessionString: session.session_string
    }
  end
end
