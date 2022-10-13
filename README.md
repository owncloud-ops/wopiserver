# wopiserver

[![Build Status](https://drone.owncloud.com/api/badges/owncloud-ops/wopiserver/status.svg)](https://drone.owncloud.com/owncloud-ops/wopiserver/)
[![Docker Hub](https://img.shields.io/badge/docker-latest-blue.svg?logo=docker&logoColor=white)](https://hub.docker.com/r/owncloudops/wopiserver)

Custom container image for Wopiserver.

## Ports

- 8880

## Volumes

- /var/wopi_local_storage

## Environment Variables

```Shell
# Valid values are: local, cs3
WOPISERVER_STORAGE_TYPE=local
# Valid values are: debug, info, warning, error
WOPISERVER_LOG_LEVEL=error

WOPISERVER_WOPI_URL=http://localhost
WOPISERVER_DOWNLOAD_URL=http://localhost

# These secrets are required, otherwise the container won't start up. It's also possible to mount
# these files to /etc/wopi/wopisecret and /etc/wopi/wopisecret and /etc/wopi/iopsecret to fulfill
# the requirement.
WOPISERVER_WOPI_SECRET=
WOPISERVER_IOP_SECRET=

WOPISERVER_BRIDGE_SSL_VERIFY=True
WOPISERVER_BRIDGE_DISABLE_ZIP=False

# Only applies on storage type 'cs3'.
WOPISERVER_CS3_SSL_VERIFY=True
```

## Build

You could use the `BUILD_VERSION` to specify the target version.

```Shell
docker build -f Dockerfile -t wopiserver:latest .
```

## Test

```Shell
docker run -p 8880:8880 \
    -e WOPISERVER_WOPI_SECRET=dummy-secret \
    -e WOPISERVER_IOP_SECRET=dummy-secret \
    -e WOPISERVER_LOG_LEVEL=debug \
    -it wopiserver:devel
```

## License

This project is licensed under the Apache 2.0 License - see the [LICENSE](https://github.com/owncloud-ops/wopiserver/blob/main/LICENSE) file for details.
