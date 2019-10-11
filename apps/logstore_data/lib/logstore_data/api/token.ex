defmodule LogstoreData.Api.Token do
  alias LogstoreData.Repo
  alias LogstoreData.Schema.Token

  def create() do
    generate_key() |> create()
  end

  def create(key) do
    %Token{key: key} |> Token.changeset(%{}) |> Repo.insert!()
  end

  def get_by_key(key) do
    Token |> Repo.get_by(key: key)
  end

  def find_or_create([]), do: create()

  def find_or_create([key]), do: find_or_create(key)

  def find_or_create(key) do
    get_by_key(key) || create(key)
  end

  defp generate_key do
    :crypto.strong_rand_bytes(32) |> Base.encode16(case: :lower)
  end
end
