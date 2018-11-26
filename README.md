
## Howto

### Build

```sh
git clone https://github.com/neomutt/test-docker
docker build test-docker
# ...
# Lots of logging
# ...
# Successfully built IMAGE_ID
```

### Run

If you have permission to open ports below 1024 (if you're root),
you can run:

```sh
docker run -p 110:110/tcp -p 143:143/tcp -p 993:993/tcp -p 994:994/tcp IMAGE_ID
```

otherwise, run this to map the ports to higher-number ports:

```sh
docker run -P IMAGE_ID
```

### Access

To get a shell in the Docker, find the ContainerID:

```sh
docker container ls
# CONTAINER ID IMAGE        ...
# ae0090e01571 2a24eb92c691 ...
```

then run:

```sh
docker exec -it CONTAINER_ID /bin/sh
```

