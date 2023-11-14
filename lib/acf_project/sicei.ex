defmodule AcfProject.SICEI do
  @moduledoc """
  The SICEI context.
  """

  import Ecto.Query, warn: false
  alias AcfProject.Repo

  alias AcfProject.SICEI.Alumno

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
