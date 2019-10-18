# Add application data
# > mix run priv/repo/seeds.exs

IO.puts "RELOADING BADGER DATA"

alias BadgerData.Schema.{User, Site, View, Token}
alias BadgerData.Repo

Repo.delete_all(User)
Repo.delete_all(Site)
Repo.delete_all(View)
Repo.delete_all(Token)

Repo.insert(
  %User{ 
    name: "aaa",
    email: "aaa",
    pwd_hash: User.pwd_hash("aaa"),
    sites: [
      %Site{name: "feedex_casmacc_net", url: "https://feedex.casmacc.net"},
      %Site{name: "jobex_sing", url: "http://sing:5070"},
      %Site{name: "bugmark_net", url: "https://bugmark.net"},
      %Site{name: "ledemo_casmacc_net", url: "https://live-editable.casmacc.net"},
      %Site{name: "connorleak.com", url: "http://connorleak.com"},
      %Site{name: "mvcondo.com", url: "http://mesa-verde-condo.com"},
      %Site{name: "badger_readme", url: "https://github.com/andyl/badger"},
      %Site{name: "feedex_readme", url: "https://github.com/andyl/feedex"},
      %Site{name: "jobex_readme", url: "https://github.com/andyl/jobex"}
    ]
  }
)

