FROM debian:latest
RUN  apt-get update \
 && apt-get install -y --no-install-recommends \
  apt-transport-https \
  ca-certificates \
  curl \
  jq \
  python-pip \
  python-setuptools \
  python-yaml \
  unzip \
  git \
  gnupg2 \
 && apt-get clean
RUN pip install --no-cache-dir yq

ENV TERRAFORM_VERSION 0.12.26
RUN curl https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip > terraform.zip \
 && unzip terraform.zip -d /bin \
 && rm terraform.zip

ENV HELM_VERSION_2 2.16.7
RUN curl -s https://storage.googleapis.com/kubernetes-helm/helm-v${HELM_VERSION_2}-linux-amd64.tar.gz | tar -zxv -C /bin --strip-components=1 --transform 's|linux-amd64/helm|linux-amd64/helm2|' linux-amd64/helm

ENV HELM_VERSION 3.2.1
RUN curl -s https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz | tar -zx -C /bin --strip-components=1 linux-amd64/helm

RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - \
 && echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list \
 && apt-get update \
 && apt-get install -y --no-install-recommends \
      kubectl \
 && apt-get clean

ENV KUSTOMIZE_VERSION 3.6.1
RUN curl https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv${KUSTOMIZE_VERSION}/kustomize_v${KUSTOMIZE_VERSION}_linux_amd64.tar.gz -L -o - | tar -zx -C /bin
