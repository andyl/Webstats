# Add application data
# > mix run priv/repo/seeds.exs

IO.puts "RELOADING LOGSTORE DATA"

alias LogstoreData.Schema.{Site, View, Token}
alias LogstoreData.Repo

Repo.delete_all(Site)
Repo.delete_all(View)
Repo.delete_all(Token)

Repo.insert(
  %Site{name: "Logstore", url: "hana"}
)

