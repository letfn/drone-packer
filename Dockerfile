FROM letfn/container AS download

ARG _PACKER_VERSION=1.5.4

WORKDIR /tmp

RUN curl -sSL -O https://releases.hashicorp.com/packer/${_PACKER_VERSION}/packer_${_PACKER_VERSION}_linux_amd64.zip \
  && unzip packer_${_PACKER_VERSION}_linux_amd64.zip \
  && chmod 755 packer

FROM letfn/container

COPY --from=download /tmp/packer /usr/local/bin/packer

COPY plugin /plugin

ENTRYPOINT [ "/tini", "--", "/plugin" ]
