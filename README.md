
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

To create a named image, use:

```sh
docker build -t dovecot-img test-docker
```

### Run

If you have permission to open ports below 1024 (if you're root),
you can run (constraining those ports only for tcp connections):

```sh
docker run -p 110:110/tcp -p 143:143/tcp -p 993:993/tcp -p 994:994/tcp IMAGE_ID
```

otherwise, run this to map the ports to higher-number ports:

```sh
docker run -P IMAGE_ID
```

You probably don't want to open ports in your system if you don't need to.
Thus, you can tie it too your loopback connection only as follows. By the way,
it seems easier to name the container since you know how to reach it. Also,
you can remove the container as soon as it finish the execution.

```sh
docker run -it --rm --name=dovecot-container \
    -p 127.0.0.1:110:110/tcp \
    -p 127.0.0.1:143:143/tcp \
    -p 127.0.0.1:993:993/tcp \
    -p 127.0.0.1:994:994/tcp \
    dovecot-img
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

### Testing

Telnet is the easier way to get a quick check using the dovecot server you
just created

```sh
$ telnet localhost 143
Trying 127.0.0.1...
Connected to localhost.
Escape character is '^]'.
* OK [CAPABILITY IMAP4rev1 SASL-IR LOGIN-REFERRALS ID ENABLE IDLE LITERAL+ AUTH=PLAIN AUTH=LOGIN] Dovecot ready.
```

Three users are available in the container:

- `fulano` with password `secret`
- `cicrano` with password `unknown`
- `beltrano` with passord `puzzle`

Again, it is possible to make a quick check while with the telnet open:

```sh
a login fulano secret
```

And list all folders

```sh
a1 list "" *
```

See a full list of raw IMAP commands [here](https://donsutherland.org/crib/imap).

### Cleaning up

The generated images are kept in a hidden place by docker. You can list them doing the following:

```sh
$ docker images
```

Removing an image is as easy as

```sh
$ docker rmi <name or hash of the image>
```

However, no container that was created based on that image should exist. To list all the containers in your machine:

```sh
$ docker ps --all
```

And, to remove a container:

```sh
$ docker rm <name or hash of the container>
```

