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
    profesor
    |> cast(attrs, [:numeroEmpleado, :nombres, :apellidos, :horasClase])
    |> validate_required([:numeroEmpleado, :nombres, :apellidos, :horasClase])
  end
end
