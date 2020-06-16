# Badger Design

Badge Generation

- Phase 1: tracking pixel
- Phase 2: tracking image
- Phase 3: information badges (like in github)

Badges can be placed:
- on the footer of websites (html)
- on README files (markdown) 

## ETAG Technique

http://lucb1e.com/rp/cookielesscookies/
https://blog.sundaycoding.com/blog/2017/03/28/etag-tracking-and-elixir/
https://github.com/adamniedzielski/etag_tracker
https://segment.com/docs/sources/server/pixel-tracking-api/
https://support.shopgate.com/hc/en-us/articles/220385507-Converting-a-tracking-pixel-from-HTML-to-JavaScript
https://alchemist.camp/episodes/event-tracking-with-keen.io

## Elements

pixel 

    <img src="http://badger.casmacc.io/img?site=YOURID&path=/base/login></img>

image

    <img src="http://badger.casmacc.io/img?site=YOURID&path=/base/login&name=YOURNAME></img>

badge

    <img ...>PNG IMAGE (Clickable)</img>

### Use with Dynamic Websites

Phoenix, Rails

### Use with Static Websites

Jekyll, Hugo

### Use with Markdown Files

README.md, etc.

## Downstream Systems

Data Records may optionally be pushed to downstream systems like Kafka,
Nats/Liftbridge, Influx and Prometheus.

A separate job runner app will be used to sync databases.

## Grafana Visualization

Visualize with Grafana, either by pulling from the PostgresDB directly, or by
pulling from the downstream systems.

## Tables

User
- name
- pass

Site
- user_id
- name
- url

Image
- site_id
- name
- path

Badge
- site_id
- type
- name
- url
- properties

View
- site_id
- time
- path
- CIP
- CUA

Downstream
- user_id
- name
- type
- address
- credentials
- last_push_at
- cursor

Export
- downstream_id
- start_at
- finish_at
- status
- cursor

## Elixir Libraries

| uainspector | https://github.com/elixir-inspector/ua_inspector |
| geolix      | https://github.com/elixir-geolix/geolix          |

## Stats

- # uniques
- time on site
