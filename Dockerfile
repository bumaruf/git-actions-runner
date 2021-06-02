FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive
ARG GH_ACTIONS_RUNNER_VERSION=2.275.1
ARG PACKAGES="apt-utils gnupg2 gnupg-agent apt-transport-https ca-certificates software-properties-common pwgen git make curl wget zip libicu-dev build-essential libssl-dev"

# Create "runner" user
RUN useradd -d /runner --uid=1000 runner \
    && echo 'runner:runner' | chpasswd \
    && mkdir /runner \
    && chown -R runner:runner /runner

# Install basic stuff
RUN apt-get update \
    && apt-get install -y --no-install-recommends ${PACKAGES} \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install docker
RUN curl -fsSL https://get.docker.com -o get-docker.sh \
    && sh get-docker.sh \
    && usermod -aG docker runner

# Install docker-compose
RUN echo Install docker-compose

USER runner
WORKDIR /runner

# Install github actions runner
RUN curl -o actions-runner-linux-x64.tar.gz -L https://github.com/actions/runner/releases/download/v${GH_ACTIONS_RUNNER_VERSION}/actions-runner-linux-x64-${GH_ACTIONS_RUNNER_VERSION}.tar.gz \
    && tar xzf ./actions-runner-linux-x64.tar.gz \
    && rm -f actions-runner-linux-x64.tar.gz

RUN docker -v && git --version

COPY start.sh /

CMD /start.sh
