FROM ubuntu:23.04

ENV DEBIAN_FRONTEND=noninteractive

# Install base packages
RUN export DEBIAN_FRONTEND=noninteractive; \
    apt-get update && \
    apt-get install --yes \
    sudo \
    locales \
    curl \
    wget \
    git \
    unzip \
    python3-minimal \
    && \
    apt-get autoremove --purge --yes && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Locales
ENV LANG="en_US.UTF-8" LC_ALL="en_US.UTF-8" LANGUAGE="en_US.UTF-8"
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen --purge $LANG && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=$LANG LC_ALL=$LC_ALL LANGUAGE=$LANGUAGE

ENV TERM=xterm-256color

# Add user
ARG USERNAME=dotfileuser
ARG USER_UID=1111
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

WORKDIR /home/$USERNAME

USER $USERNAME
