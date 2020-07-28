# Add application data
# > mix run priv/repo/seed_dev.exs

IO.puts "RELOADING BADGER DATA"

alias BadgerData.Schema.{User, Site, View, Token, Seed}
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
        name: "dev1",
        type: "influx",
        config: %{
          host: "influx_host",
          port: "8086",
          user: "admin",
          pass: "ADMIN",
          database: "badger_dev"
        }
      }
    ], 
    sites: [
      Util.sitefor("badger_host",        "http://localhost"                 , "Badger"), 
      Util.sitefor("badger_404",         "http://tbd"                       , "404404"), 
      Util.sitefor("feedex_casmacc_net", "https://feedex.casmacc.net"       , "Feedex"),
      Util.sitefor("jobex_sing",         "http://sing:5070"                 , "Jobexx"),
      Util.sitefor("bugmark_net",        "https://bugmark.net"              , "Bugnet"),
      Util.sitefor("ledemo_casmacc_net", "https://live-editable.casmacc.net", "LeDemo"),
      Util.sitefor("connorleak_com",     "http://connorleak.com"            , "CKLeak"),
      Util.sitefor("mvcondo_com",        "http://mesa-verde-condo.com"      , "MvCndo"),
      Util.sitefor("casmacc_io_pro",     "http://casmacc.io"                , "CsmcIO"),
      Util.sitefor("casmacc_io_dev",     "http://dixy:1313"                 , "aaaaa1"),
      Util.sitefor("zipwork_io_pro",     "http://zipwork.io"                , "aaaaa2"),
      Util.sitefor("zipwork_io_dev",     "http://dixy:1313"                 , "aaaaa3"),
      Util.sitefor("starvan_io_pro",     "http://zipwork.io"                , "aaaaa4"),
      Util.sitefor("starvan_io_dev",     "http://dixy:1313"                 , "aaaaa5"),
      Util.sitefor("badger_readme",      "https://github.com/andyl/badger"  , "BadgRM"),
      Util.sitefor("feedex_readme",      "https://github.com/andyl/feedex"  , "FedxRM"),
      Util.sitefor("jobex_readme",       "https://github.com/andyl/jobex"   , "JobxRM")
    ]
  }
)
