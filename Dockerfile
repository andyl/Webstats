# >>>>>> LocalTest
# Build: docker build -t phx-webstats .
# Run:   docker run -p 8444:4000 phx-webstats
#
# >>>>>> DockerHub
# Build: docker build -t <yourname>/webstats .
# Login: docker login -u <yourname>
# Push:  docker push <yourname>/webstats
# Run:   docker run -p 8444:4000 <yourname>/webstats

FROM elixir:1.9

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

WORKDIR /app
ENV MIX_ENV=prod
COPY _build/prod/rel/webstats /app/
EXPOSE 4000

CMD /app/bin/webstats foreground
