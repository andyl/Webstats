defmodule BadgerWeb.Plug.SiteTag do
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    tag = BadgerWeb.Util.Host.badger_host().tag
    assign(conn, :host_tag, tag)
  end
end
