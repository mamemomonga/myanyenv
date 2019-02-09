FROM ubuntu:bionic

RUN set -xe && \
	export DEBIAN_FRONTEND=noninteractive && \
	apt-get update && \
	apt-get install -y --no-install-recommends \
		ca-certificates \
		curl \
		gpg \
		gpg-agent \
		git-core \
		build-essential \
		zlib1g-dev \
		libffi-dev \
		libbz2-dev \
		libssl-dev \
		libreadline-dev \
		libsqlite3-dev && \
	rm -rf /var/lib/apt/lists/*

RUN set -xe && \
	useradd -m -u 10000 app

USER app

RUN echo 'set -xe && \
	git clone https://github.com/anyenv/anyenv ~/.anyenv && \
	export PATH="$HOME/.anyenv/bin:$PATH" && \
	eval "$(anyenv init -)" && \
	yes | anyenv install --init && \
	anyenv install plenv && \
	anyenv install nodenv && \
	anyenv install pyenv' | bash

RUN echo 'set -xe && \
	export PATH="$HOME/.anyenv/bin:$PATH" && \
	eval "$(anyenv init -)" && \
	plenv install 5.28.1 && \
	plenv global 5.28.1 && \
	plenv install-cpanm && \
	cpanm install Carton' | bash

RUN echo 'set -xe && \
	export PATH="$HOME/.anyenv/bin:$PATH" && \
	eval "$(anyenv init -)" && \
	nodenv install 11.9.0 && \
	nodenv global 11.9.0 && \
	node -v && \
	npm -v && \
	curl -o- -L https://yarnpkg.com/install.sh | sh ' | bash

RUN echo 'set -xe && \
	export PATH="$HOME/.anyenv/bin:$PATH" && \
	eval "$(anyenv init -)" && \
	pyenv install 3.7.1 && \
	pyenv global 3.7.1' | bash

