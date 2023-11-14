defmodule AcfProject.Repo.Migrations.CreateAlumnos do
  use Ecto.Migration

  def change do
    create table(:alumnos) do
      add :nombres, :string
      add :apellidos, :string
      add :matricula, :string
      add :promedio, :float

      timestamps()
    end
  end
end
