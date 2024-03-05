ARG VERSION=latest
FROM chimeralinux/chimera:${VERSION}

ENV PACKAGE=main/acl

RUN apk add --no-interactive                 \
        bash                                 \
        shadow                               \
        base-cbuild-bootstrap                \
 && /bin/bash -c "useradd admin"             \
 && /bin/bash -c "echo user:user | chpasswd" \
 && /bin/bash -c "echo root:root | chpasswd"

USER admin
VOLUME /build
WORKDIR /build/cports

CMD true \
  && /bin/bash -c "./cbuild keygen || true"            \
  && /bin/bash -c "./cbuild binary-bootstrap || true"  \
  && /bin/bash -c "./cbuild pkg ${PACKAGE}"

