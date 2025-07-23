# To get docker and docker-buildx dependency on the gcloud :slim image
# https://cloud.google.com/sdk/docs/dockerfile_example
FROM docker:28.3.2 as static-docker-source
FROM gcr.io/google.com/cloudsdktool/google-cloud-cli:slim
COPY --from=static-docker-source /usr/local/bin/docker /usr/local/bin/docker
COPY --from=static-docker-source /usr/local/libexec/docker/cli-plugins/docker-buildx /usr/local/libexec/docker/cli-plugins/docker-buildx
LABEL maintainer "Ibuki Nakamura"

RUN apt-get update -y && \
    apt-get install -y kubectl && \
    curl -Lo /usr/local/bin/skaffold https://storage.googleapis.com/skaffold/releases/latest/skaffold-linux-amd64 && chmod +x /usr/local/bin/skaffold && \
    curl -s https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh | bash && mv kustomize /usr/local/bin/kustomize
