defmodule BadgerWeb.Util.Host do
  use Memoize

  defmemo badger_host do
    BadgerData.Api.Site.badger_host()
  end

  defmemo badger_404 do
    BadgerData.Api.Site.badger_404()
  end
end
