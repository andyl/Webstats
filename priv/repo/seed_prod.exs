# Add application data
# > mix run priv/repo/seed_prod.exs

IO.puts "RELOADING BADGER DATA"

alias BadgerData.Schema.{User, Site, View, Token}
alias BadgerData.{Repo, Util}

Repo.delete_all(User)
Repo.delete_all(Site)
Repo.delete_all(View)
Repo.delete_all(Token)

Repo.insert(
  %User{ 
    id: 1, 
    name: "aaa",
    email: "aaa",
    pwd_hash: User.pwd_hash("aaa"),
    downstreams: [
      %{
        name: "prod1",
        type: "influx",
        config: %{
          host: "localhost",
          port: "8086",
          user: "admin",
          pass: "ADMIN",
          database: "badger_prod"
        }
      }
    ], 
    sites: [
      Util.sitefor("badger_host",        "http://localhost"                          , "aaaaaa"), 
      Util.sitefor("badger_404",         "http://tbd"                                , "404404"), 
      Util.sitefor("feedex_casmacc_net", "https://feedex.casmacc.net"                , "feedex"),
      Util.sitefor("jobex_sing",         "http://sing:5070"                          , "jobexx"),
      Util.sitefor("bugmark_net",        "https://bugmark.net"                       , "bugnet"),
      Util.sitefor("ledemo_casmacc_net", "https://live-editable.casmacc.net"         , "ledemo"),
      Util.sitefor("connorleak_com",     "http://connorleak.com"                     , "ckleak"),
      Util.sitefor("mvcondo_com",        "http://mesa-verde-condo.com"               , "mvcndo"),
      Util.sitefor("casmacc_io_pro",     "http://casmacc.io"                         , "csmcio"),
      Util.sitefor("casmacc_io_dev",     "http://dixy:1313"                          , "aaaaa1"),
      Util.sitefor("zipwork_io_pro",     "http://zipwork.io"                         , "aaaaa2"),
      Util.sitefor("zipwork_io_dev",     "http://dixy:1313"                          , "aaaaa3"),
      Util.sitefor("starvan_io_pro",     "http://zipwork.io"                         , "aaaaa4"),
      Util.sitefor("starvan_io_dev",     "http://dixy:1313"                          , "aaaaa5"),
      Util.sitefor("badger_readme",      "https://github.com/andyl/badger"           , "aaaaa6"),
      Util.sitefor("feedex_readme",      "https://github.com/andyl/feedex"           , "aaaaa7"),
      Util.sitefor("jobex_readme",       "https://github.com/andyl/jobex"            , "aaaaa8"),
      Util.sitefor("extending_readme",   "https://github.com/andyl/extending_elixir" , "aaaaa9")
    ]
  }
)
