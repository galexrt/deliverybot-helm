FROM alpine:3.17.2

ENV BASE_URL="https://get.helm.sh"

ENV HELM_3_FILE="helm-v3.11.1-linux-amd64.tar.gz"

COPY . /usr/src/

RUN apk add --no-cache ca-certificates \
    --repository http://dl-3.alpinelinux.org/alpine/edge/community/ \
    jq curl bash nodejs npm aws-cli && \
    curl -L ${BASE_URL}/${HELM_3_FILE} |tar xvz && \
    mv linux-amd64/helm /usr/bin/helm && \
    chmod +x /usr/bin/helm && \
    rm -rf linux-amd64 && \
    ln -sfn /usr/bin/helm /usr/bin/helm3 && \
    cd /usr/src && \
    npm install

ENV PYTHONPATH "/usr/lib/python3.10/site-packages/"

ENTRYPOINT ["node", "/usr/src/index.js"]
