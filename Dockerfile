FROM progrium/consul
# FROM alpine:3.2

# # from progrium/consul 0.6
# # https://github.com/gliderlabs/docker-consul/blob/master/0.6/consul/Dockerfile


ENV CONSUL_VER 0.6.4
ENV CONSUL_CLI_VER 0.2.0 
ENV CT_VER 0.14.0 



RUN apk --update add wget

# # consul webui
WORKDIR /tmp

RUN wget https://releases.hashicorp.com/consul/${CONSUL_VER}/consul_${CONSUL_VER}_web_ui.zip && \
    mv consul_${CONSUL_VER}_web_ui.zip consul_ui.zip && \
    unzip consul_ui.zip



# # consul-template
RUN wget https://releases.hashicorp.com/consul-template/${CT_VER}/consul-template_${CT_VER}_linux_amd64.zip && \
    mv consul-template_${CT_VER}_linux_amd64.zip consul_template.zip && \
    unzip consul-template_${CT_VER}_linux_amd64 && \
    chmod +x /usr/local/bin/consul-template


# # consul-cli
RUN curl -fsL https://github.com/CiscoCloud/consul-cli/releases/download/v${CONSUL_CLI_VER}/consul-cli_${CONSUL_CLI_VER}_linux_amd64.tar.gz | tar xzf - -C /tmp/ && \
    mv /tmp/consul-cli_${CONSUL_CLI_VER}_linux_amd64/consul-cli /usr/local/bin/ && \
    rm -rf /tmp/consul-cli_${CONSUL_CLI_VER}_linux_amd64



# ENTRYPOINT ["/bin/consul", "agent", "-config-dir=/config", "-ui"]
ENTRYPOINT ["/bin/consul", "server", "-config-dir=/config"]