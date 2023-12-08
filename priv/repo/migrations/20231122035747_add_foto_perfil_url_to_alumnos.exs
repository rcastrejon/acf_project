defmodule AcfProject.Repo.Migrations.AddFotoPerfilUrlToAlumnos do
  use Ecto.Migration

  def change do
    alter table(:alumnos) do
      add :foto_perfil_url, :string
    end
  end
end
