ARG ALPINE_VERSION=3.18

FROM alpine:${ALPINE_VERSION}
ARG USERNAME=atlas

LABEL \
    org.opencontainers.image.authors="atlas@chez.com" \
    org.opencontainers.image.created=$CREATED \
    org.opencontainers.image.version=$VERSION \
    org.opencontainers.image.revision=$COMMIT \
    org.opencontainers.image.url="https://github.com/Atlas34/alpinedevcontainer" \
    org.opencontainers.image.documentation="https://github.com/Atlas34/alpinedevcontainer" \
    org.opencontainers.image.source="https://github.com/Atlas34/alpinedevcontainer" \
    org.opencontainers.image.title="Atlas Alpine Base Dev container" \
    org.opencontainers.image.description="Alpine development container for Visual Studio using dev Container extension for development"

# CA certificates
RUN apk add -q --update --progress --no-cache ca-certificates

# Timezone
RUN apk add -q --update --progress --no-cache tzdata sudo
ENV TZ="Europe/Paris"

# Add new user
RUN addgroup -S ${USERNAME}
RUN adduser -s /bin/zsh -G ${USERNAME} -S ${USERNAME} -D

# Add sudo support for non-root user
RUN echo ${USERNAME} ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/${USERNAME}
RUN chmod 0440 /etc/sudoers.d/${USERNAME}

# Setup all package
RUN apk add -q --update --progress --no-cache bash zsh htop curl wget rsync zip unzip git mandoc git-doc vim \
    openssh-client jq libgcc libstdc++ zlib lazygit fzf fd ripgrep gnupg strace coreutils sed which bat \
    procps lsof net-tools psmisc less tar xz tmux

# Set Atlas home dir folder as default folder
WORKDIR /home/${USERNAME}

# Setup shell for root and ${USERNAME}
ENTRYPOINT [ "/bin/zsh" ]
ENV EDITOR=vim \
    LANG=en_US.UTF-8 \
    # MacOS compatibility
    TERM=xterm
RUN apk add -q --update --progress --no-cache shadow && \
    usermod --shell /bin/zsh ${USERNAME} && \
    apk del shadow

# Set default user as atlas
USER ${USERNAME}

# Add default set of aliases
RUN mkdir -p /home/${USERNAME}/.config
COPY shell/aliases /home/${USERNAME}/.config/

# Configure user by adding zshPlug and default set of plugin
COPY shell/.zshrc /home/${USERNAME}/
RUN mkdir -p /home/${USERNAME}/.local/share
RUN cd /home/${USERNAME} ; curl -s https://raw.githubusercontent.com/Atlas34/zshPlug/master/install.sh -o install.sh ; chmod +x install.sh ; ./install.sh ; rm install.sh
