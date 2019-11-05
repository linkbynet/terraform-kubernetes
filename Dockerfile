FROM debian:latest
RUN  apt-get update \
 && apt-get install -y --no-install-recommends \
  apt-transport-https \
  ca-certificates \
  curl \
  jq \
  python-pip \
  python-yaml \
  unzip \
  git \
  gnupg2 \
 && apt-get clean \
 && pip install --no-cache-dir yq

ENV TERRAFORM_VERSION 0.11.13
RUN curl https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip > terraform.zip \
 && unzip terraform.zip -d /bin \
 && rm terraform.zip

ENV HELM_VERSION 2.13.1
RUN curl https://storage.googleapis.com/kubernetes-helm/helm-v${HELM_VERSION}-linux-amd64.tar.gz | tar -zx -C /bin --strip-components=1

RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - \
 && echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list \
 && apt-get update \
 && apt-get install -y --no-install-recommends \
      kubectl \
 && apt-get clean
