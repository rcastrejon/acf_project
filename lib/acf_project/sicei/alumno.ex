defmodule AcfProject.SICEI.Alumno do
  use Ecto.Schema
  import Ecto.Changeset

  schema "alumnos" do
    field :nombres, :string
    field :apellidos, :string
    field :matricula, :string
    field :promedio, :float

    field :foto_perfil_url, :string
    field :password, :string

    timestamps()
  end

  @doc false
  def changeset(alumno, attrs) do
    alumno
    |> cast(attrs, [:nombres, :apellidos, :matricula, :promedio, :password])
    |> validate_required([:nombres, :apellidos, :matricula, :promedio, :password])
  end

  def change_profile_picture_url(alumno, profile_picture_url)
      when is_binary(profile_picture_url) do
    alumno
    |> change(foto_perfil_url: profile_picture_url)
    |> validate_required([:foto_perfil_url])
  end

  def valid_password?(%AcfProject.SICEI.Alumno{password: alumno_password}, password) do
    alumno_password == password
  end

  def build_session(%AcfProject.SICEI.Alumno{} = alumno) do
    %{
      id: Ecto.UUID.generate(),
      fecha: DateTime.utc_now() |> DateTime.to_unix(:second),
      alumno_id: alumno.id,
      active: true,
      session_string: :crypto.strong_rand_bytes(128) |> Base.url_encode64() |> binary_part(0, 128)
    }
  end
end
