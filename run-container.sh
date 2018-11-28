## must be executed from test-docker folder
## the image "dovecot-container" should be available as well.

mkdir -p homefs

docker run -it --rm --name=dovecot-container \
    -p 127.0.0.1:110:110/tcp \
    -p 127.0.0.1:143:143/tcp \
    -p 127.0.0.1:993:993/tcp \
    -p 127.0.0.1:994:994/tcp \
    -v $PWD/homefs:/home \
    dovecot-img

