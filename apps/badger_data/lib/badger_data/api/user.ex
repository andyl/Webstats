defmodule BadgerData.Api.User do
  alias BadgerData.Schema.User
  alias BadgerData.Repo
  import Ecto.Query

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
