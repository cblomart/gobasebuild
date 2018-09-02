FROM golang:latest
MAINTAINER cblomart@gmail.com


# install nodejs
RUN curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -;\
    echo 'deb http://deb.nodesource.com/node_10.x stretch main' > /etc/apt/sources.list.d/nodesource.list;\
    apt-get update && apt-get install -y\
    nodejs upx\
    upx-ucl\
    musl\
    musl-tools &&\
    apt-get clean &&\
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# install golang checkers
RUN export CGO=0;\
    go get -ldflags '-s -w' -a honnef.co/go/tools/cmd/gosimple;\
    go get -ldflags '-s -w' -a golang.org/x/lint/golint;\
    go get -ldflags '-s -w' -a github.com/gordonklaus/ineffassign;\
    go get -ldflags '-s -w' -a github.com/securego/gosec/cmd/gosec/...;\
    go get -ldflags '-s -w' -a github.com/dave/courtney;\
    upx -qq --best --lzma ./bin/gosimple;\
    upx -qq --best --lzma ./bin/golint;\
    upx -qq --best --lzma ./bin/ineffassign;\
    upx -qq --best --lzma ./bin/gosec;\
    upx -qq --best --lzma ./bin/courtney;\
    cp ./bin/* /usr/local/bin/;\
    rm -rf ./*
    
# install docker
RUN curl -Ss https://download.docker.com/linux/static/stable/x86_64/docker-18.06.1-ce.tgz | tar -C /tmp -zxf  -;\
    mv /tmp/docker/docker /usr/local/bin/

# codeclimate cover reporter

ADD https://codeclimate.com/downloads/test-reporter/test-reporter-latest-linux-amd64 /usr/local/bin/test-reporter
