defmodule AcfProject.SICEI.Alumno do
  use Ecto.Schema
  import Ecto.Changeset

  schema "alumnos" do
    field :nombres, :string
    field :apellidos, :string
    field :matricula, :string
    field :promedio, :float

    field :foto_perfil_url, :string

    timestamps()
  end

  @doc false
  def changeset(alumno, attrs) do
    alumno
    |> cast(attrs, [:nombres, :apellidos, :matricula, :promedio])
    |> validate_required([:nombres, :apellidos, :matricula, :promedio])
  end

  def change_profile_picture_url(alumno, profile_picture_url)
      when is_binary(profile_picture_url) do
    alumno
    |> change(foto_perfil_url: profile_picture_url)
    |> validate_required([:foto_perfil_url])
  end
end
