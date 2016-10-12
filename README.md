This is a Dockerfile for the [stringer](https://github.com/swanson/stringer) RSS reader. Concepts are heavily inspired by DonnieWest's [Dockerfile](https://github.com/DonnieWest/dockerfiles/tree/master/stringer), but uses an Alpine based image and adds some features.

## Usage
```sh-session
$ docker run -d --name stringer \
    -p 5000:5000 \
    -v stringer-data:/data \
    -e STRINGER_FETCH_INTERVAL='10m' \
    -e STRINGER_CLEANUP_INTERVAL='30d' \
    browncoatshadow/stringer
```

- `-p 5000:5000` publishes stringer's port.
- `-v stringer-data:/data` creates a named persistent volume that holds stringer's database.
- `-e STRINGER_FETCH_INTERVAL='10m'` sets the interval for fetching feeds.  Defaults to 10 minutes if not set.
- `-e STRINGER_CLEANUP_INTERVAL='30d'` sets the interval for cleaning up old stories in the database. Defaults to 30 days if not set.
