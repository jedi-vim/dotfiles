FROM debian:buster

COPY .pre-configure-env.sh .
RUN sh .pre-configure-env.sh

RUN adduser --disabled-password --shell /usr/bin/zsh dev_user
USER dev_user:root
WORKDIR /home/dev_user

RUN mkdir -p .config
RUN mkdir -p .local
ADD kitty .config/kitty
ADD nvim  .config/nvim

ADD .configure-env.sh .
RUN zsh .configure-env.sh

ADD zshrc .config/

CMD /usr/bin/zsh
