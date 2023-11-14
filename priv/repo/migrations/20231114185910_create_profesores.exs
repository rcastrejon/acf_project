defmodule AcfProject.Repo.Migrations.CreateProfesores do
  use Ecto.Migration

  def change do
    create table(:profesores) do
      add :numeroEmpleado, :integer
      add :nombres, :string
      add :apellidos, :string
      add :horasClase, :integer

      timestamps()
    end
  end
end
