defmodule AcfProjectWeb.AlumnoControllerTest do
  use AcfProjectWeb.ConnCase

  import AcfProject.SICEIFixtures

  alias AcfProject.SICEI.Alumno

  @create_attrs %{
    nombres: "some nombres",
    apellidos: "some apellidos",
    matricula: "some matricula",
    promedio: 120.5
  }
  @update_attrs %{
    nombres: "some updated nombres",
    apellidos: "some updated apellidos",
    matricula: "some updated matricula",
    promedio: 456.7
  }
  @invalid_attrs %{nombres: nil, apellidos: nil, matricula: nil, promedio: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all alumnos", %{conn: conn} do
      conn = get(conn, ~p"/api/alumnos")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create alumno" do
    test "renders alumno when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/alumnos", alumno: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/alumnos/#{id}")

      assert %{
               "id" => ^id,
               "apellidos" => "some apellidos",
               "matricula" => "some matricula",
               "nombres" => "some nombres",
               "promedio" => 120.5
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/alumnos", alumno: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update alumno" do
    setup [:create_alumno]

    test "renders alumno when data is valid", %{conn: conn, alumno: %Alumno{id: id} = alumno} do
      conn = put(conn, ~p"/api/alumnos/#{alumno}", alumno: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/alumnos/#{id}")

      assert %{
               "id" => ^id,
               "apellidos" => "some updated apellidos",
               "matricula" => "some updated matricula",
               "nombres" => "some updated nombres",
               "promedio" => 456.7
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, alumno: alumno} do
      conn = put(conn, ~p"/api/alumnos/#{alumno}", alumno: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete alumno" do
    setup [:create_alumno]

    test "deletes chosen alumno", %{conn: conn, alumno: alumno} do
      conn = delete(conn, ~p"/api/alumnos/#{alumno}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/alumnos/#{alumno}")
      end
    end
  end

  defp create_alumno(_) do
    alumno = alumno_fixture()
    %{alumno: alumno}
  end
end
