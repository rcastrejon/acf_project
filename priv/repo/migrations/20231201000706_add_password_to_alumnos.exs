defmodule AcfProject.Repo.Migrations.AddPasswordToAlumnos do
  use Ecto.Migration

  def change do
    alter table(:alumnos) do
      add :password, :string, default: "password"
    end
  end
end
