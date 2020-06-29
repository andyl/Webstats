defmodule BadgerWeb.LayoutView do
  use BadgerWeb, :view

  def hdr_link(conn, lbl, path) do
    ~e"""
    <li class="nav-item">
      <%= active_link(conn, lbl, to: path, class_active: "nav-link active", class_inactive: "nav-link") %>
    </li>
    """
  end

  def logout_link(conn, user) do
    path = Routes.session_path(conn, :delete, user)
    ~e"""
    <li class="nav-item">
      <%= link "LOGOUT", to: path, method: "delete", class: "nav-link" %>
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
    host_tag = conn.assigns.host_tag
    r_path = conn.request_path
    """
    <img src="/png0/#{host_tag}?path=#{r_path}">
    """ |> Phoenix.HTML.raw()
  end
end
