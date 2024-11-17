The Dockerfile compiles Mattermost to test it. The entrypoint starts bash after setting the database to DB_URL
Example:
```
docker build -t mm .
docker run --rm -it -p 8080:8065 -e DB_URL='postgres://yugabyte:yugabyte@yb0.pachot.net:5433?sslmode=disable&connect_timeout=10&binary_parameters=yes' mm
```

Start the server:
```
make run-server
until [ -r /var/tmp/mattermost_local.socket ] ; do sleep 1 ; done
```

run some sample data
```
make test-data
bin/mmctl sampledata --posts-per-channel 10000 --local
```

Connect to YugabyteDB with:
```
psql ${DB_URL%binary_parameters*}

```
