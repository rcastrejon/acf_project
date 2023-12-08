defmodule AcfProject.SICEI do
  @moduledoc """
  The SICEI context.
  """

  import Ecto.Query, warn: false
  alias AcfProject.Sicei.Session
  alias AcfProject.Repo

  alias AcfProject.SICEI.Alumno
  @session_table "sesiones-alumnos"

  @doc """
  Returns the list of alumnos.

  ## Examples

      iex> list_alumnos()
      [%Alumno{}, ...]

  """
  def list_alumnos do
    Repo.all(Alumno)
  end

  @doc """
  Gets a single alumno.

  Raises `Ecto.NoResultsError` if the Alumno does not exist.

  ## Examples

      iex> get_alumno!(123)
      %Alumno{}

      iex> get_alumno!(456)
      ** (Ecto.NoResultsError)

  """
  def get_alumno!(id), do: Repo.get!(Alumno, id)

  @doc """
  Creates a alumno.

  ## Examples

      iex> create_alumno(%{field: value})
      {:ok, %Alumno{}}

      iex> create_alumno(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_alumno(attrs \\ %{}) do
    %Alumno{}
    |> Alumno.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a alumno.

  ## Examples

      iex> update_alumno(alumno, %{field: new_value})
      {:ok, %Alumno{}}

      iex> update_alumno(alumno, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_alumno(%Alumno{} = alumno, attrs) do
    alumno
    |> Alumno.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Updates a alumno's profile picture URL.

  ## Examples

      iex> update_alumno_profile_picture_url(alumno, "https://example.com/profile_picture.jpg")
      {:ok, %Alumno{}}

      iex> update_alumno_profile_picture_url(invalid_alumno, "https://example.com/profile_picture.jpg")
      {:error, %Ecto.Changeset{}}
  """
  def update_alumno_profile_picture_url(%Alumno{} = alumno, profile_picture_url)
      when is_binary(profile_picture_url) do
    alumno
    |> Alumno.change_profile_picture_url(profile_picture_url)
    |> Repo.update()
  end

  def get_alumno_by_id_and_password(id, password) when is_binary(id) and is_binary(password) do
    alumno = Repo.get_by!(Alumno, id: id)
    if Alumno.valid_password?(alumno, password), do: alumno
  end

  def generate_alumno_session(alumno) do
    session = Alumno.build_session(alumno)

    case ExAws.Dynamo.put_item(@session_table, session)
         |> ExAws.request() do
      {:ok, _} -> {:ok, session}
      {:error, _} -> {:error, :s3_error}
    end
  end

  def verify_alumno_session(session_string) when is_binary(session_string) do
    with {:ok, %{"Item" => _} = response} <-
           ExAws.Dynamo.get_item(@session_table, %{
             session_string: session_string
           })
           |> ExAws.request() do
      {:ok, response |> ExAws.Dynamo.decode_item(as: Session)}
    else
      _ -> {:error, :s3_error}
    end
  end

  def expire_alumno_session(session_string)
      when is_binary(session_string) do
    ExAws.Dynamo.delete_item(@session_table, %{
      session_string: session_string
    })
    |> ExAws.request()
  end

  @doc """
  Deletes a alumno.

  ## Examples

      iex> delete_alumno(alumno)
      {:ok, %Alumno{}}

      iex> delete_alumno(alumno)
      {:error, %Ecto.Changeset{}}

  """
  def delete_alumno(%Alumno{} = alumno) do
    Repo.delete(alumno)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking alumno changes.

  ## Examples

      iex> change_alumno(alumno)
      %Ecto.Changeset{data: %Alumno{}}

  """
  def change_alumno(%Alumno{} = alumno, attrs \\ %{}) do
    Alumno.changeset(alumno, attrs)
  end

  alias AcfProject.SICEI.Profesor

  @doc """
  Returns the list of profesores.

  ## Examples

      iex> list_profesores()
      [%Profesor{}, ...]

  """
  def list_profesores do
    Repo.all(Profesor)
  end

  @doc """
  Gets a single profesor.

  Raises `Ecto.NoResultsError` if the Profesor does not exist.

  ## Examples

      iex> get_profesor!(123)
      %Profesor{}

      iex> get_profesor!(456)
      ** (Ecto.NoResultsError)

  """
  def get_profesor!(id), do: Repo.get!(Profesor, id)

  @doc """
  Creates a profesor.

  ## Examples

      iex> create_profesor(%{field: value})
      {:ok, %Profesor{}}

      iex> create_profesor(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_profesor(attrs \\ %{}) do
    %Profesor{}
    |> Profesor.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a profesor.

  ## Examples

      iex> update_profesor(profesor, %{field: new_value})
      {:ok, %Profesor{}}

      iex> update_profesor(profesor, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_profesor(%Profesor{} = profesor, attrs) do
    profesor
    |> Profesor.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a profesor.

  ## Examples

      iex> delete_profesor(profesor)
      {:ok, %Profesor{}}

      iex> delete_profesor(profesor)
      {:error, %Ecto.Changeset{}}

  """
  def delete_profesor(%Profesor{} = profesor) do
    Repo.delete(profesor)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking profesor changes.

  ## Examples

      iex> change_profesor(profesor)
      %Ecto.Changeset{data: %Profesor{}}

  """
  def change_profesor(%Profesor{} = profesor, attrs \\ %{}) do
    Profesor.changeset(profesor, attrs)
  end
end
