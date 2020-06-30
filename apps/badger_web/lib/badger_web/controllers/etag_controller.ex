defmodule BadgerWeb.EtagController do
  use BadgerWeb, :controller

  alias BadgerData.Api

  def png0(conn, params), do: send_img(conn, "png0", params)
  def gif0(conn, params), do: send_img(conn, "gif0", params)
  def jpg0(conn, params), do: send_img(conn, "jpg0", params)
  def pngF(conn, params), do: send_img(conn, "pngF", params)
  def gifF(conn, params), do: send_img(conn, "gifF", params)
  def jpgF(conn, params), do: send_img(conn, "jpgF", params)

  # ---------------------------------------

  defp send_img(conn, filetype, params) do
    ipath = pixel_filepath(filetype)
    token = find_or_create_token(conn, params) 
    ftype = String.split(ipath, ".") |> List.last()

    if unquote(Mix.env == :test) do
      record_view(token, conn, params)
    else
      Task.start(fn -> record_view(token, conn, params) end)
    end

    conn
    |> put_resp_header("etag", token.key)
    |> put_format("image/#{ftype}")
    |> send_file(200, ipath, 0, :all)
  end

  defp record_view(token, conn, _params) do
  
    opts = %{
      client_ip: conn.remote_ip |> Tuple.to_list() |> Enum.join(".") || "",
      client_ua: ua_for(conn)
    }

    # create view record
    view = Api.View.create(opts, token: token)

    # enqueue export job
    %{view_id: view.id}
    |> BadgerData.Workers.Test1Worker.new() 
    |> Oban.insert()

  end

  defp ua_for(conn) do
    case Plug.Conn.get_req_header(conn, "user-agent") do
      [] -> ""
      [val] -> val
      list -> list |> Enum.join(", ")
    end
  end

  defp find_or_create_token(conn, params) do
    conn
    |> get_req_header("if-none-match")
    |> Api.Token.find_or_create(params)
  end

  defp pixel_filepath(type) do
    pix_base = "#{:code.priv_dir(:badger_web)}/pixels"
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
