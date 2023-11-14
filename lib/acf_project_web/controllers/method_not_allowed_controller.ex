defmodule AcfProjectWeb.MethodNotAllowedController do
  use AcfProjectWeb, :controller

  def match(%Plug.Conn{path_info: path_info} = conn, _params) do
    routes =
      AcfProjectWeb.Router.__routes__()
      |> Enum.map(& &1.path)
      |> Enum.uniq()
      |> Enum.map(&(&1 |> String.split("/") |> Enum.drop(1)))

    if path_info in routes do
      send_resp(conn, 405, "")
    else
      send_resp(conn, 404, "")
    end
  end
end
