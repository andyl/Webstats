defmodule BadgerData.Exporters.Influx do

  # TODO
  # - add a test function (server up)
  # - add a test function (can login)
  # - add a test function (database active)
  # - add a function to create a database
  # - create an exporter behavior - 3 functions: test, setup, write

  def write(elapsed, tags, config) do
    write_point("page_view", %{elapsed: elapsed}, tags, config)
  end

  defp write_point(measurement, vals, tags, config) do
    tagstr = Enum.map(tags, fn({k,v}) -> "#{k}=#{v}" end) |> Enum.join(",")
    valstr = Enum.map(vals, fn({k,v}) -> "#{k}=#{v}" end) |> Enum.join(",")
    "#{measurement},#{tagstr} #{valstr}"
    |> send()
  end

  # async send, fire and forget
  def send(body, cfg) do
    url = "#{cfg.host}:#{cfg.port}/write?db=#{cfg.database}&time_precision=s"
    opt = [body: body, basic_auth: {cfg.user, cfg.pass}]
    Task.start(fn -> HTTPotion.post(url, opt) end)
  end
end
