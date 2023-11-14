defmodule AcfProject.SICEI.Alumno do
  use Ecto.Schema
  import Ecto.Changeset

  schema "alumnos" do
    field :nombres, :string
    field :apellidos, :string
    field :matricula, :string
    field :promedio, :float

    timestamps()
  end

  @doc false
  def changeset(alumno, attrs) do
    # id only necessary in-memory repo
    alumno
    |> cast(attrs, [:id, :nombres, :apellidos, :matricula, :promedio])
    |> validate_required([:id, :nombres, :apellidos, :matricula, :promedio])
  end
end
