defmodule BadgerWeb.UserView do
  use BadgerWeb, :view

  alias BadgerData.Schema.User

  def first_name(%User{name: name}) do
    name
    |> String.split(" ")
    |> Enum.at(0)
  end
end
