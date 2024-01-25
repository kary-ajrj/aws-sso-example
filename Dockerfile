FROM alpine:3.19.0 as aws-sso-oidc-tools

RUN apk add --no-cache aws-cli && \
    apk add --no-cache curl && \
    release=`curl -s https://api.github.com/repos/hashicorp/terraform/releases/latest |  grep tag_name | cut -d: -f2 | tr -d \"\,\v | awk '{$1=$1};1'` && \
    wget https://releases.hashicorp.com/terraform/${release}/terraform_${release}_linux_amd64.zip && \
    unzip terraform_${release}_linux_amd64.zip && \
    mv terraform /usr/bin/terraform

ENTRYPOINT ["/bin/sh", "-c"]
