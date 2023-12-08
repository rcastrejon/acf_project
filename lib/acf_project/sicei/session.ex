defmodule AcfProject.Sicei.Session do
  @derive [ExAws.Dynamo.Encodable]
  defstruct [:id, :fecha, :alumno_id, :session_string, :active]
end
