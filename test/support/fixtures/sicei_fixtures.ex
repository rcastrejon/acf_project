defmodule AcfProject.SICEIFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `AcfProject.SICEI` context.
  """

  @doc """
  Generate a alumno.
  """
  def alumno_fixture(attrs \\ %{}) do
    {:ok, alumno} =
      attrs
      |> Enum.into(%{
        apellidos: "some apellidos",
        matricula: "some matricula",
        nombres: "some nombres",
        promedio: 120.5
      })
      |> AcfProject.SICEI.create_alumno()

    alumno
  end
end
