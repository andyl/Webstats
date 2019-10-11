# Remove all application data
# > mix run priv/repo/clear.exs

alias LogstoreData.Schema.{Site, View, Token}
alias LogstoreData.Repo

Repo.delete_all(Site)
Repo.delete_all(View)
Repo.delete_all(Token)
