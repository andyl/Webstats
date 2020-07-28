defmodule BadgerData.Util do
  alias BadgerData.Schema.Site

  def sitefor(name, url) do
    sitefor(name, url, Site.tag_for_name(name))
  end

  def sitefor(name, url, tag) do
    %Site{
      url: url,
      name: name,
      tag: tag
    }
  end
end

