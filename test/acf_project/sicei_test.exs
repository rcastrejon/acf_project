defmodule AcfProject.SICEITest do
  use AcfProject.DataCase

  alias AcfProject.SICEI

  describe "alumnos" do
    alias AcfProject.SICEI.Alumno

    import AcfProject.SICEIFixtures

    @invalid_attrs %{nombres: nil, apellidos: nil, matricula: nil, promedio: nil}

    test "list_alumnos/0 returns all alumnos" do
      alumno = alumno_fixture()
      assert SICEI.list_alumnos() == [alumno]
    end

    test "get_alumno!/1 returns the alumno with given id" do
      alumno = alumno_fixture()
      assert SICEI.get_alumno!(alumno.id) == alumno
    end

    test "create_alumno/1 with valid data creates a alumno" do
      valid_attrs = %{nombres: "some nombres", apellidos: "some apellidos", matricula: "some matricula", promedio: 120.5}

      assert {:ok, %Alumno{} = alumno} = SICEI.create_alumno(valid_attrs)
      assert alumno.nombres == "some nombres"
      assert alumno.apellidos == "some apellidos"
      assert alumno.matricula == "some matricula"
      assert alumno.promedio == 120.5
    end

    test "create_alumno/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = SICEI.create_alumno(@invalid_attrs)
    end

    test "update_alumno/2 with valid data updates the alumno" do
      alumno = alumno_fixture()
      update_attrs = %{nombres: "some updated nombres", apellidos: "some updated apellidos", matricula: "some updated matricula", promedio: 456.7}

      assert {:ok, %Alumno{} = alumno} = SICEI.update_alumno(alumno, update_attrs)
      assert alumno.nombres == "some updated nombres"
      assert alumno.apellidos == "some updated apellidos"
      assert alumno.matricula == "some updated matricula"
      assert alumno.promedio == 456.7
    end

    test "update_alumno/2 with invalid data returns error changeset" do
      alumno = alumno_fixture()
      assert {:error, %Ecto.Changeset{}} = SICEI.update_alumno(alumno, @invalid_attrs)
      assert alumno == SICEI.get_alumno!(alumno.id)
    end

    test "delete_alumno/1 deletes the alumno" do
      alumno = alumno_fixture()
      assert {:ok, %Alumno{}} = SICEI.delete_alumno(alumno)
      assert_raise Ecto.NoResultsError, fn -> SICEI.get_alumno!(alumno.id) end
    end

    test "change_alumno/1 returns a alumno changeset" do
      alumno = alumno_fixture()
      assert %Ecto.Changeset{} = SICEI.change_alumno(alumno)
    end
  end

  describe "profesores" do
    alias AcfProject.SICEI.Profesor

    import AcfProject.SICEIFixtures

    @invalid_attrs %{numeroEmpleado: nil, nombres: nil, apellidos: nil, horasClase: nil}

    test "list_profesores/0 returns all profesores" do
      profesor = profesor_fixture()
      assert SICEI.list_profesores() == [profesor]
    end

    test "get_profesor!/1 returns the profesor with given id" do
      profesor = profesor_fixture()
      assert SICEI.get_profesor!(profesor.id) == profesor
    end

    test "create_profesor/1 with valid data creates a profesor" do
      valid_attrs = %{numeroEmpleado: 42, nombres: "some nombres", apellidos: "some apellidos", horasClase: 42}

      assert {:ok, %Profesor{} = profesor} = SICEI.create_profesor(valid_attrs)
      assert profesor.numeroEmpleado == 42
      assert profesor.nombres == "some nombres"
      assert profesor.apellidos == "some apellidos"
      assert profesor.horasClase == 42
    end

    test "create_profesor/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = SICEI.create_profesor(@invalid_attrs)
    end

    test "update_profesor/2 with valid data updates the profesor" do
      profesor = profesor_fixture()
      update_attrs = %{numeroEmpleado: 43, nombres: "some updated nombres", apellidos: "some updated apellidos", horasClase: 43}

      assert {:ok, %Profesor{} = profesor} = SICEI.update_profesor(profesor, update_attrs)
      assert profesor.numeroEmpleado == 43
      assert profesor.nombres == "some updated nombres"
      assert profesor.apellidos == "some updated apellidos"
      assert profesor.horasClase == 43
    end

    test "update_profesor/2 with invalid data returns error changeset" do
      profesor = profesor_fixture()
      assert {:error, %Ecto.Changeset{}} = SICEI.update_profesor(profesor, @invalid_attrs)
      assert profesor == SICEI.get_profesor!(profesor.id)
    end

    test "delete_profesor/1 deletes the profesor" do
      profesor = profesor_fixture()
      assert {:ok, %Profesor{}} = SICEI.delete_profesor(profesor)
      assert_raise Ecto.NoResultsError, fn -> SICEI.get_profesor!(profesor.id) end
    end

    test "change_profesor/1 returns a profesor changeset" do
      profesor = profesor_fixture()
      assert %Ecto.Changeset{} = SICEI.change_profesor(profesor)
    end
  end
end
