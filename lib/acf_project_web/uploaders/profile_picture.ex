defmodule AcfProject.ProfilePicture do
  use Waffle.Definition

  @versions [:original]
  @extension_whitelist ~w(.jfif .jfif-tbnl .jif .jpe .jpeg .jpg .pjpg)

  # Whitelist file extensions:
  def validate({file, _}) do
    file_extension = file.file_name |> Path.extname() |> String.downcase()

    case Enum.member?(@extension_whitelist, file_extension) do
      true -> :ok
      false -> {:error, "invalid file type"}
    end
  end

  # Override the persisted filenames:
  def filename(version, _) do
    version
  end

  # Override the storage directory:
  def storage_dir(_version, {_file, scope}) do
    "uploads/profile_pictures/#{scope.id}"
  end
end
