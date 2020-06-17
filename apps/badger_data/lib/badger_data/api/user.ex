defmodule BadgerData.Api.User do
  alias BadgerData.Schema.{User, Site, Token, View, Downstream}
  alias BadgerData.Repo
  import Ecto.Query

  # ----- user_one -----

  def user_one do
    Repo.get_by(User, id: 1) || 
      User.changeset(%User{}, %{name: "aaa", email: "aaa", id: 1}) |> Repo.insert!()
  end

  # ----- queries -----

  def sites(user_id) do
    from(sit in Site,
      where: sit.user_id == ^user_id,
      order_by: sit.name,
      select: %{
        site_id: sit.id,
        site_name: sit.name,
        site_url: sit.url
      }
    )
    |> Repo.all()
  end

  def views(user_id) do
    from(sit in Site,
      join: tok in Token,
      on: tok.site_id == sit.id,
      join: vie in View,
      on: vie.token_id == tok.id,
      where: sit.user_id == ^user_id,
      order_by: [desc: vie.id],
      limit: 100,
      select: %{
        site_id: sit.id,
        site_name: sit.name,
        site_url: sit.url,
        token_id: tok.id,
        token_path: tok.path,
        view_id: vie.id,
        view_cip: vie.client_ip,
        view_cua: vie.client_ua,
        view_date: vie.inserted_av
      }
    )
    |> Repo.all()
  end

  def downstreams(user_id) do
    from(dstream in Downstream,
      where: dstream.user_id == ^user_id,
      order_by: dstream.name,
      select: %{
        downstream_id: dstream.id,
        downstream_name: dstream.name,
        downstream_url: dstream.url
      }
    )
    |> Repo.all()
  end

  # ----- users -----

  def user_list do
    Repo.all(User)
  end

  def user_get(user_id) do
    Repo.get(User, user_id)
  end

  def user_get_by(params) do
    Repo.get_by(User, params)
  end

  def user_get_by_email(email) do
    from(usr in User, where: fragment("email ilike ?", ^email))
    |> Repo.one()
  end

  def user_add(opts) do
    %User{}
    |> User.changeset(opts)
    |> Repo.insert()
  end

  def user_signup(opts) do
    %User{}
    |> User.signup_changeset(opts)
    |> Repo.insert()
  end

  def user_changeset(%User{} = user) do
    User.changeset(user, %{})
  end

  def user_change(_user_id) do
  end

  def user_change_pwd(_user_id, _newpwd) do
  end

  def user_delete(_user_id) do
  end

  def user_auth_by_email_and_pwd(email, pwd) do
    user = user_get_by_email(email)

    cond do
      user && Pbkdf2.verify_pass(pwd, user.pwd_hash) ->
        {:ok, user}

      user ->
        {:error, :unauthorized}

      true ->
        Pbkdf2.no_user_verify()
        {:error, :not_found}
    end
  end
end
