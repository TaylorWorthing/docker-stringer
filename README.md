This is a Dockerfile for the [stringer](https://github.com/swanson/stringer) RSS reader. Concepts are heavily inspired by DonnieWest's [Dockerfile](https://github.com/DonnieWest/dockerfiles/tree/master/stringer), but uses an Alpine based image and adds some features.

## Usage
```sh-session
$ docker run -d --name stringer -p 5000:5000 -v stringer-data:/data browncoatshadow/stringer
```

### Environment Variables
- `'STRINGER_FETCH_INTERVAL=10m'` Sets the interval for fetching feeds.  Defaults to 10 minutes if not set.
- `'STRINGER_CLEANUP_INTERVAL=30d'` Sets the interval for cleaning up old stories in the database. Defaults to 30 days if not set.

## Custom Patches
I have included some custom patches for stringer in this image.
- Unread news feed is sorted chronologically with oldest posts first.
- Keyboard shortcuts for navigating feed lists do not loop around when reaching the end of a list.
