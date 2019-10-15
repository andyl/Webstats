# Remove all application data
# > mix run priv/repo/clear.exs

alias BadgerData.Schema.{Site, View, Token}
alias BadgerData.Repo

Repo.delete_all(Site)
Repo.delete_all(View)
Repo.delete_all(Token)
