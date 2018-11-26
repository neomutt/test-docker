FROM alpine:3.8

# Update base system
RUN apk update
RUN apk add --no-cache ca-certificates
RUN update-ca-certificates

# Install all alpine dovecot packages (except documentation and development files)
RUN apk add --no-cache \
    dovecot \
    dovecot-pigeonhole-plugin \
    dovecot-pgsql \
    dovecot-mysql \
    dovecot-sqlite \
    dovecot-gssapi \
    dovecot-ldap \
    postfix

ADD passwd /etc/dovecot/passwd
ADD dovecot.conf /etc/dovecot/dovecot.conf

RUN install -m 640 -o dovecot -g mail /dev/null /etc/dovecot/users

# Mail storage directory, TLS key directory & Dovecot socket directory
VOLUME /var/lib/mail /etc/ssl/dovecot /run/dovecot

#   24: LMTP
#  110: POP3 (StartTLS)
#  143: IMAP4 (StartTLS)
#  993: IMAP (SSL, deprecated)
#  995: POP3 (SSL, deprecated)
# 4190: ManageSieve (StartTLS)
EXPOSE 24 110 143 993 995 4190

CMD dovecot -F
# CMD /bin/sh -c "sleep 3600"

