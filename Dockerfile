FROM golang:latest
MAINTAINER cblomart@gmail.com


# install nodejs
RUN curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -;\
    echo 'deb http://deb.nodesource.com/node_10.x stretch main' > /etc/apt/sources.list.d/nodesource.list;\
    apt-get update && apt-get install -y nodejs upx;\
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# install golang checkers
RUN export CGO=0;\
    go get -ldflags '-s -w' -a honnef.co/go/tools/cmd/gosimple;\
    go get -ldflags '-s -w' -a golang.org/x/lint/golint;\
    go get -ldflags '-s -w' -a github.com/gordonklaus/ineffassign;\
    go get -ldflags '-s -w' -a github.com/securego/gosec/cmd/gosec/...;\
    upx -qq --best --lzma ./bin/gosimple;\
    upx -qq --best --lzma ./bin/golint;\
    upx -qq --best --lzma ./bin/ineffassign;\
    upx -qq --best --lzma ./bin/gosec;\
    cp ./bin/* /usr/local/bin/
    rm -rf ./*

# install snyk
RUN npm install -g snyk
