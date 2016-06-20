FROM progrium/consul
# FROM alpine:3.2

# # from progrium/consul 0.6
# # https://github.com/gliderlabs/docker-consul/blob/master/0.6/consul/Dockerfile

# ENV CONSUL_VER 0.6.4
ENV CONSUL_CLI_VER 0.2.0 
ENV CT_VER 0.14.0 
ENV CONSUL_SHA256 abdf0e1856292468e2c9971420d73b805e93888e006c76324ae39416edcf0627
ENV GLIBC_VERSION "2.23-r1"

# RUN apk --update add curl wget tar ca-certificates && \
#     curl -Ls https://github.com/andyshinn/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk > /tmp/glibc-${GLIBC_VERSION}.apk && \
#     apk add --allow-untrusted /tmp/glibc-${GLIBC_VERSION}.apk && \
#     rm -rf /tmp/glibc-${GLIBC_VERSION}.apk /var/cache/apk/*


# WORKDIR /tmp
# RUN wget https://releases.hashicorp.com/consul/${CONSUL_VER}/consul_${CONSUL_VER}_linux_amd64.zip && \
#     mv consul_${CONSUL_VER}_linux_amd64.zip consul.zip



# RUN echo "${CONSUL_SHA256}  /tmp/consul.zip" > /tmp/consul.sha256 \
#   && sha256sum -c /tmp/consul.sha256 \
#   && cd /bin \
#   && unzip /tmp/consul.zip \
#   && chmod +x /bin/consul \
#   && rm /tmp/consul.zip



# # consul webui

# https://releases.hashicorp.com/consul/0.6.4/consul_0.6.4_web_ui.zip



# # consul-template
WORKDIR /tmp
# consul-template
RUN curl -Lsf https://releases.hashicorp.com/consul-template/${CT_VER}/consul-template_${CT_VER}_linux_amd64.zip 
RUN unzip consul-template_${CT_VER}_linux_amd64 # -d /usr/local/bin/ 
RUN chmod +x /usr/local/bin/consul-template


# # consul-cli
RUN curl -fsL https://github.com/CiscoCloud/consul-cli/releases/download/v${CONSUL_CLI_VER}/consul-cli_${CONSUL_CLI_VER}_linux_amd64.tar.gz | tar xzf - -C /tmp/ && \
    mv /tmp/consul-cli_${CONSUL_CLI_VER}_linux_amd64/consul-cli /usr/local/bin/ && \
    rm -rf /tmp/consul-cli_${CONSUL_CLI_VER}_linux_amd64



ENTRYPOINT ["/bin/consul"]
