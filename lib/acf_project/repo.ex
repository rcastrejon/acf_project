defmodule AcfProject.Repo do
  # use Ecto.Repo,
  #   otp_app: :acf_project,
  #   adapter: Ecto.Adapters.Postgres

  def all(module) do
    :ets.tab2list(module) |> Enum.map(&elem(&1, 1))
  end

  def get!(module, id) do
    case :ets.lookup(module, cast_id(id)) do
      [] -> raise Ecto.NoResultsError.exception(queryable: module)
      [{_, result}] -> result
    end
  end

  def insert(changeset) do
    with {:ok, struct} <- apply_changeset(changeset),
         module <- root_module(struct) do
      :ets.insert(module, {struct.id, struct})
      {:ok, struct}
    else
      {:error, changeset} -> {:error, changeset}
    end
  end

  def update(changeset) do
    with {:ok, struct} <- apply_changeset(changeset),
         module <- root_module(struct) do
      :ets.insert(module, {struct.id, struct})
      {:ok, struct}
    else
      {:error, changeset} -> {:error, changeset}
    end
  end

  def delete(struct) do
    module = root_module(struct)

    :ets.delete(module, struct.id)
    {:ok, struct}
  end

  defp cast_id(id) when is_binary(id) do
    case Integer.parse(id) do
      :error -> nil
      {id, _rest} -> id
    end
  end

  defp apply_changeset(%{valid?: false} = changeset), do: {:error, changeset}
  defp apply_changeset(changeset), do: {:ok, Ecto.Changeset.apply_changes(changeset)}

  defp root_module(%{__meta__: %{schema: module}}), do: module
end
