FROM ubuntu:18.04 AS base
WORKDIR /opt/scratch
RUN apt-get update && \
    apt-get install -y \
        apt-transport-https \
        ca-certificates \
        curl \
        git \
        gnupg-agent \
        neovim \
        python \
        python3-neovim \
        software-properties-common \
        unzip \
        && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
    add-apt-repository \
        "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
        $(lsb_release -cs) \
        stable" && \
    apt-get update && \
    apt-get install -y docker-ce-cli && \
    curl https://raw.githubusercontent.com/kennethreitz/pipenv/master/get-pipenv.py | python && \
    curl -fsSL https://github.com/Schniz/fnm/raw/master/.ci/install.sh | bash && \
    curl -o bat.deb -fsSL https://github.com/sharkdp/bat/releases/download/v0.11.0/bat_0.11.0_amd64.deb && \
    dpkg -i bat.deb && \
    rm -rf ./* && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /opt/src

# neovim stuff
RUN git clone https://gitlab.com/samantha.aurora.enders/sammi-dotfiles && \
    cd sammi-dotfiles && \
    mkdir -p ~/.config && \
    cp -r nvim ~/.config/nvim && \
    cp .vimrc ~/.vimrc && \
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

WORKDIR /
ENTRYPOINT [ "bash" ]
