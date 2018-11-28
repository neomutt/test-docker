
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
    -p 127.0.0.1:143:143/tcp \
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
