defmodule LogstoreWeb.LayoutView do
  use LogstoreWeb, :view

  def hdr_link(conn, lbl, path) do
    ~e"""
    <li class="nav-item">
      <%= active_link(conn, lbl, to: path, class_active: "nav-link active", class_inactive: "nav-link") %>
    </li>
    """
  end

  def ftr_link(conn, lbl, path) do
    ~e"""
    <li class="nav-item">
      <%= active_link(conn, lbl, to: path, class_active: "nav-link disabled", class_inactive: "nav-link") %>
    </li>
    """
  end

  def footer_img(conn) do
    hostid = LogstoreData.Api.Site.apphost_id()
    r_path = conn.request_path
    """
    <img src="/png0/#{hostid}?path=#{r_path}"></img>
    """ |> Phoenix.HTML.raw()
  end
end
