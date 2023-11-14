defmodule AcfProjectWeb.ProfesorControllerTest do
  use AcfProjectWeb.ConnCase

  import AcfProject.SICEIFixtures

  alias AcfProject.SICEI.Profesor

  @create_attrs %{
    numeroEmpleado: 42,
    nombres: "some nombres",
    apellidos: "some apellidos",
    horasClase: 42
  }
  @update_attrs %{
    numeroEmpleado: 43,
    nombres: "some updated nombres",
    apellidos: "some updated apellidos",
    horasClase: 43
  }
  @invalid_attrs %{numeroEmpleado: nil, nombres: nil, apellidos: nil, horasClase: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all profesores", %{conn: conn} do
      conn = get(conn, ~p"/api/profesores")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create profesor" do
    test "renders profesor when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/profesores", profesor: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/profesores/#{id}")

      assert %{
               "id" => ^id,
               "apellidos" => "some apellidos",
               "horasClase" => 42,
               "nombres" => "some nombres",
               "numeroEmpleado" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/profesores", profesor: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update profesor" do
    setup [:create_profesor]

    test "renders profesor when data is valid", %{conn: conn, profesor: %Profesor{id: id} = profesor} do
      conn = put(conn, ~p"/api/profesores/#{profesor}", profesor: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/profesores/#{id}")

      assert %{
               "id" => ^id,
               "apellidos" => "some updated apellidos",
               "horasClase" => 43,
               "nombres" => "some updated nombres",
               "numeroEmpleado" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, profesor: profesor} do
      conn = put(conn, ~p"/api/profesores/#{profesor}", profesor: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete profesor" do
    setup [:create_profesor]

    test "deletes chosen profesor", %{conn: conn, profesor: profesor} do
      conn = delete(conn, ~p"/api/profesores/#{profesor}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/profesores/#{profesor}")
      end
    end
  end

  defp create_profesor(_) do
    profesor = profesor_fixture()
    %{profesor: profesor}
  end
end
