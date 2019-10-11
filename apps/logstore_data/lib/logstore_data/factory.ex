defmodule LogstoreData.Factory do
  use ExMachina.Ecto, repo: LogstoreData.Repo
  alias LogstoreData.Schema.{View, Site, Token}

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
end
