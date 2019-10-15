# Add application data
# > mix run priv/repo/seeds.exs

IO.puts "RELOADING LOGSTORE DATA"

alias BadgerData.Schema.{Site, View, Token}
alias BadgerData.Repo

Repo.delete_all(Site)
Repo.delete_all(View)
Repo.delete_all(Token)

Repo.insert(
  %Site{name: "Badger", url: "hana"}
)

