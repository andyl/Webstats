defmodule BadgerData.Exporters.Influx do

  # TODO
  # - add a test function (server up)
  # - add a test function (can login)
  # - add a test function (database active)
  # - add a function to create a database
  # - create an exporter behavior

  def write_point(measurement, vals, tags) do
    tagstr = Enum.map(tags, fn({k,v}) -> "#{k}=#{v}" end) |> Enum.join(",")
    valstr = Enum.map(vals, fn({k,v}) -> "#{k}=#{v}" end) |> Enum.join(",")
    "#{measurement},#{tagstr} #{valstr}"
    |> send()
  end

  # async send, fire and forget
  def send(body) do
    host 
    db  = Application.get_env(:badger_data, FeedexData.Exporters.Influx)[:database]
    url = "localhost:8086/write?db=#{db}&time_precision=s"
    opt = [body: body, basic_auth: {"admin", "admin"}]
    Task.start(fn -> HTTPotion.post(url, opt) end)
  end
end
