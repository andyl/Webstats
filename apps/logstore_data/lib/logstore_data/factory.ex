defmodule LogstoreData.Factory do
  use ExMachina.Ecto, repo: LogstoreData.Repo
  alias LogstoreData.Schema.{User, View, Site, Token}

  def site_factory do
    %Site{
      name: "Site1"
    }
  end

  def view_factory do
    %View{
    }
  end

  def token_factory do
    %Token{
      key: "asdf"
    }
  end

  def user_factory do
    pwd = "welcome"
    %User{
      name: sequence(:name, &"user_#{&1}"),
      email: sequence(:email, &"user_#{&1}@test_domain.com"),
      pwd_hash: Pbkdf2.hash_pwd_salt(pwd) 
    }
  end
end
