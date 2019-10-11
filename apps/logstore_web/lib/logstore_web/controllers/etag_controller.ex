defmodule LogstoreWeb.EtagController do
  use LogstoreWeb, :controller

  alias LogstoreData.Api

  def png0(conn, params), do: send_img(conn, "png0", params)
  def gif0(conn, params), do: send_img(conn, "gif0", params)
  def jpg0(conn, params), do: send_img(conn, "jpg0", params)
  def pngF(conn, params), do: send_img(conn, "pngF", params)
  def gifF(conn, params), do: send_img(conn, "gifF", params)
  def jpgF(conn, params), do: send_img(conn, "jpgF", params)

  # ---------------------------------------

  defp send_img(conn, filetype, params) do
    ipath = pixel_filepath(filetype)
    token = find_or_create_token(conn) 
    ftype = String.split(ipath, ".") |> List.last()

    record_view(token, conn, params)

    conn
    |> put_resp_header("etag", token.key)
    |> put_format("image/#{ftype}")
    |> send_file(200, ipath, 0, :all)
  end

  defp record_view(token, _conn, _params) do
    Api.View.create(%{}, token: token)
  end

  defp find_or_create_token(conn) do
    conn
    |> get_req_header("if-none-match")
    |> Api.Token.find_or_create()
  end

  defp pixel_filepath(type) do
    pix_base = "#{:code.priv_dir(:logstore_web)}/pixels"
    case type do
      "png0"  -> "#{pix_base}/000.png"
      "gif0"  -> "#{pix_base}/000.gif"
      "jpg0"  -> "#{pix_base}/000.jpg"
      "pngF"  -> "#{pix_base}/FFF.png"
      "gifF"  -> "#{pix_base}/FFF.gif"
      "jpgF"  -> "#{pix_base}/FFF.jpg"
    end
  end
end
