FROM ocramz/docker-phusion-supervisor
# FROM progrium/consul
# FROM alpine:3.2

# # from progrium/consul 0.6
# # https://github.com/gliderlabs/docker-consul/blob/master/0.6/consul/Dockerfile


ENV CONSUL_VER 0.6.4
ENV CONSUL_CLI_VER 0.2.0 
ENV CT_VER 0.14.0 
ENV CONSUL_SHA256 abdf0e1856292468e2c9971420d73b805e93888e006c76324ae39416edcf0627


# # dirs
ENV CONSUL_WEBUI_DIR /opt/consul-web-ui
ENV CONSUL_DATA_DIR /var/consul
RUN mkdir -p ${CONSUL_WEBUI_DIR}
RUN mkdir -p ${CONSUL_DATA_DIR}


RUN apt-get upgrade && \
    apt-get install -y curl wget ca-certificates

ADD https://releases.hashicorp.com/consul/${CONSUL_VER}/consul_${CONSUL_VER}_linux_amd64.zip /tmp/consul.zip
RUN echo "${CONSUL_SHA256}  /tmp/consul.zip" > /tmp/consul.sha256 \
  && sha256sum -c /tmp/consul.sha256 \
  && cd /bin \
  && unzip /tmp/consul.zip \
  && chmod +x /bin/consul \
  && rm /tmp/consul.zip



# # consul webui
WORKDIR ${CONSUL_WEBUI_DIR}

RUN wget https://releases.hashicorp.com/consul/${CONSUL_VER}/consul_${CONSUL_VER}_web_ui.zip && \
    unzip consul_${CONSUL_VER}_web_ui.zip && \
    rm consul_${CONSUL_VER}_web_ui.zip




WORKDIR /tmp

# # consul-template
RUN wget https://releases.hashicorp.com/consul-template/${CT_VER}/consul-template_${CT_VER}_linux_amd64.zip && \
    unzip consul-template_${CT_VER}_linux_amd64.zip && \
    rm consul-template_${CT_VER}_linux_amd64.zip
    
RUN mv consul-template /usr/local/bin/consul-template && \
    chmod +x /usr/local/bin/consul-template




# # consul-cli
RUN curl -fsL https://github.com/CiscoCloud/consul-cli/releases/download/v${CONSUL_CLI_VER}/consul-cli_${CONSUL_CLI_VER}_linux_amd64.tar.gz | tar xzf - -C /tmp/ && \
    mv /tmp/consul-cli_${CONSUL_CLI_VER}_linux_amd64/consul-cli /usr/local/bin/ && \
    rm -rf /tmp/consul-cli_${CONSUL_CLI_VER}_linux_amd64


# Consul agent configuration in config/agent.json
ENTRYPOINT ["/bin/consul", "agent", "-config-dir=/config", "-ui-dir=/tmp"]

# ENTRYPOINT ["/bin/consul", "agent", "-server", "-config-dir=/config"]
# ENTRYPOINT ["/bin/bash"]



# # # clean temp data
RUN sudo apt-get clean && \
    apt-get purge && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*