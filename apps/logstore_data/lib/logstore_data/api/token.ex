defmodule LogstoreData.Api.Token do
  alias LogstoreData.Repo
  alias LogstoreData.Schema.Token

  def get_by_key(key) do
    Token |> Repo.get_by(key: key)
  end

  def create(params) do
    generate_key() |> create(params)
  end

  def create(key, params) do
    %Token{key: key} |> Token.changeset(params) |> Repo.insert!()
  end

  def find_or_create([], params), do: create(params)

  def find_or_create([key], params), do: find_or_create(key, params)

  def find_or_create(key, params) do
    get_by_key(key) || create(key, params)
  end

  defp generate_key do
    :crypto.strong_rand_bytes(24) |> Base.encode16(case: :lower)
  end
end
