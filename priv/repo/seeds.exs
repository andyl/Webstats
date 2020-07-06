# Add application data
# > mix run priv/repo/seeds.exs

IO.puts "RELOADING BADGER DATA"

alias BadgerData.Schema.{User, Site, View, Token}
alias BadgerData.Repo

defmodule Lcl do
  def sitefor(name, url) do
    %Site{
      url: url,
      name: name,
      tag: Site.tag_for_name(name)
    }
  end
end

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
        name: "test1",
        type: "influx",
        config: %{
          host: "influx_host",
          port: "8086",
          user: "admin",
          pass: "admin",
          database: "badger_dev"
        }
      }
    ], 
    sites: [
      Lcl.sitefor("badger_host",        "http://localhost"), 
      Lcl.sitefor("badger_404",         "http://tbd"), 
      Lcl.sitefor("feedex_casmacc_net", "https://feedex.casmacc.net"),
      Lcl.sitefor("jobex_sing",         "http://sing:5070"),
      Lcl.sitefor("bugmark_net",        "https://bugmark.net"),
      Lcl.sitefor("ledemo_casmacc_net", "https://live-editable.casmacc.net"),
      Lcl.sitefor("connorleak_com",     "http://connorleak.com"),
      Lcl.sitefor("mvcondo_com",        "http://mesa-verde-condo.com"),
      Lcl.sitefor("casmacc_io_pro",     "http://casmacc.io"),
      Lcl.sitefor("casmacc_io_dev",     "http://dixy:1313"),
      Lcl.sitefor("zipwork_io_pro",     "http://zipwork.io"),
      Lcl.sitefor("zipwork_io_dev",     "http://dixy:1313"),
      Lcl.sitefor("starvan_io_pro",     "http://zipwork.io"),
      Lcl.sitefor("starvan_io_dev",     "http://dixy:1313"),
      Lcl.sitefor("badger_readme",      "https://github.com/andyl/badger"),
      Lcl.sitefor("feedex_readme",      "https://github.com/andyl/feedex"),
      Lcl.sitefor("jobex_readme",       "https://github.com/andyl/jobex")
    ]
  }
)
