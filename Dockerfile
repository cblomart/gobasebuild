FROM golang:latest
MAINTAINER cblomart@gmail.com


# install nodejs
RUN curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -;\
    echo 'deb http://deb.nodesource.com/node_10.x stretch main' > /etc/apt/sources.list.d/nodesource.list;\
    apt-get update && apt-get install -y nodejs upx;\
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# install golang checkers
RUN go get honnef.co/go/tools/cmd/gosimple;\
    go get golang.org/x/lint/golint;\
    go get github.com/gordonklaus/ineffassign;\
    go get github.com/securego/gosec/cmd/gosec/...;\

# install snyk
RUN npm install -g snyk
