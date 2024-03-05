ARG VERSION=latest
FROM chimeralinux/chimera:${VERSION}

ENV PACKAGE=main/acl

RUN apk add --no-interactive \
        bash \
        shadow \
        base-cbuild-bootstrap \
 && useradd admin \
 && echo user:user | chpasswd \
 && echo root:root | chpasswd

USER admin
VOLUME /build
WORKDIR /build/cports

CMD true \
  && ./cbuild keygen || true
  && ./cbuild binary-bootstrap || true
  && ./cbuild pkg ${PACKAGE}

