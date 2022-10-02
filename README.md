# Virtual Dash

An web app to compete for cash prices easily and virtually with friends and have race organizers create completely virtual events that are hassle free.

[](./1-part.mov)

[](./2-part.mov)

## Development of App

To start the application run the following docker command

```bash
# create DB & migrations (DB will be up'd with this command)
docker-compose -f ./docker/docker-compose.yml run --service-ports --rm web bundle exec rake db:create db:migrate
# run rails application (along with DB)
docker-compose -f ./docker/docker-compose.yml run --service-ports --rm web
```

```bash
# run workers
docker-compose -f ./docker/docker-compose.yml run --service-ports --rm worker
```
