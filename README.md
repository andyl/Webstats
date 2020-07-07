# Badger

Badge Server

To get running in dev mode:

    > cd apps/badger_web/assets
    > npm install
    > cd ../../..
    > mix do deps.get, ecto.create, ecto.setup
    > mix phx.server

## Production requirements

- Ubuntu Host running 18.04 or 20.04
- SystemD
- Postgres (user/pass = postgres/postgres)

## Installing

- Clone the repo
- Install assets
    > cd apps/badger_web/assets
    > npm install
    > cd ../../..
- `MIX_ENV=prod mix do deps.get, ecto.create, ecto.setup, release`
- Start the release
- Browse to `locahost:5020`

## Using SystemD

Create the database and run the migrations.  Then:

- edit the SystemD service file in `rel/badger.service`
- `sudo cp rel/badger.service /etc/systemd/system`
- `sudo chmod 644 /etc/systemd/system/badger.service`

Start the service with SystemD

- `sudo systemctl start badger`
- `sudo systemctl status badger`
- `sudo systemctl restart badger`
- `sudo systemctl stop badger`
- `sudo journalctl -u badger -f`

Make sure your service starts when the system reboots

- `sudo systemctl enable badger`

Reboot and test!

