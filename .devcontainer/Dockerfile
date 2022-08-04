# pre-build stage
ARG VARIANT=""
FROM mcr.microsoft.com/vscode/devcontainers/ruby:${VARIANT}

# Update args in docker-compose.yaml to set the UID/GID of the "vscode" user.
ARG USER_UID=1000
ARG USER_GID=$USER_UID
RUN if [ "$USER_GID" != "1000" ] || [ "$USER_UID" != "1000" ]; then \
        groupmod --gid $USER_GID vscode \
        && usermod --uid $USER_UID --gid $USER_GID vscode \
        && chmod -R $USER_UID:$USER_GID /home/vscode; \
    fi

# [Option] Install Node.js
ARG INSTALL_NODE=""
ARG NODE_VERSION=""
RUN if [ "${INSTALL_NODE}" = "true" ]; then su vscode -c "source /usr/local/share/nvm/nvm.sh && nvm install ${NODE_VERSION} 2>&1"; fi

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
  && apt-get -y install --no-install-recommends \
    libssl-dev \
    tar \
    tzdata \
    postgresql-client \
    yarn \
    git \
    imagemagick \
    tmux \
    zsh \
    vim \
    python-dev \
    imagemagick

RUN echo "alias fs='foreman start -f ./Procfile.dev-server'" >> ~/.bashrc
RUN echo "export EDITOR='vim'" >> ~/.bashrc

# Do the set up required for chatwoot app 
WORKDIR /workspace
COPY . /workspace
RUN gem install bundler && bundle install
RUN gem install solargraph
RUN gem install foreman
RUN gem install rufo -v 0.12.0
RUN gem install annotate
# RUN curl https://cli-assets.heroku.com/install.sh | sh
# RUN heroku plugins:install heroku-builds

#download documentation for ruby
# RUN solargraph download-core
# RUN solargraph bundle

# uncomment de generate documentation for gems for solargraph
# warning: takes a lot of time
#RUN yard gems
#RUN yard config --gem-install-yri