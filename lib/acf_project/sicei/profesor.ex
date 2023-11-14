defmodule AcfProject.SICEI.Profesor do
  use Ecto.Schema
  import Ecto.Changeset

  schema "profesores" do
    field :numeroEmpleado, :integer
    field :nombres, :string
    field :apellidos, :string
    field :horasClase, :integer

    timestamps()
  end

  @doc false
  def changeset(profesor, attrs) do
    # id only necessary in-memory repo
    profesor
    |> cast(attrs, [:id, :numeroEmpleado, :nombres, :apellidos, :horasClase])
    |> validate_required([:id, :numeroEmpleado, :nombres, :apellidos, :horasClase])
  end
end
