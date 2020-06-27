defmodule BadgerData.Factory do
  use ExMachina.Ecto, repo: BadgerData.Repo
  alias BadgerData.Schema.{User, View, Site, Token, Downstream, Export}

  def site_factory do
    seq_name = sequence(:name, &"Site_#{&1}")
    %Site{
      name: seq_name,
      tag: Site.tag_for_name(seq_name)
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

  def downstream_factory do
    %Downstream{
      name: sequence(:name, &"downstream_#{&1}"),
      type: "influxdb",
      address: "localhost:3050", 
      credentials: "{'user': 'admin', 'pass': 'admin'}"
    }
  end

  def export_factory do
    %Export{
      starting_record: 10,
      ending_record: 15,
      num_records: 4
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
