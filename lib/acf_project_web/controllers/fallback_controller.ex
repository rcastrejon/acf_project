defmodule AcfProjectWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use AcfProjectWeb, :controller

  # This clause handles errors returned by Ecto's insert/update/delete.
  # :bad_request is necessary to pass the assignment's tests.
  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:bad_request)
    |> put_view(json: AcfProjectWeb.ChangesetJSON)
    |> render(:error, changeset: changeset)
  end

  # This clause is an example of how to handle resources that cannot be found.
  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(html: AcfProjectWeb.ErrorHTML, json: AcfProjectWeb.ErrorJSON)
    |> render(:"404")
  end
end
