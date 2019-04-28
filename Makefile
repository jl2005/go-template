PROJECT_NAME := TODO
PKG := TODO/$(PROJECT_NAME)
PKG_LIST := $(shell go list ${PKG}/... | grep -v /vendor/)
GITHASH := $(shell git rev-parse --short HEAD)
GO_FILES := $(shell find . -name '*.go' | grep -v /vendor/ | grep -v _test.go)

LDFLAGS += -X "$(PKG)/util.ReleaseVersion=$(shell git tag  --contains)"
LDFLAGS += -X "$(PKG)/util.BuildTS=$(shell date -u '+%Y-%m-%d %I:%M:%S')"
LDFLAGS += -X "$(PKG)/util.GitHash=$(GITHASH)"
LDFLAGS += -X "$(PKG)/util.GolangVersion=$(shell go version)"
LDFLAGS += -X "$(PKG)/util.GitLog=$(shell git log --abbrev-commit --oneline -n 1 | sed 's/$(GITHASH)//g')"
LDFLAGS += -X "$(PKG)/util.GitBranch=$(shell git rev-parse --abbrev-ref HEAD)"

.PHONY: all build clean test coverage lint proto
all: build

test:
	env GO111MODULE=on go test -short ${PKG_LIST}

coverage:
	env GO111MODULE=on go test -covermode=count -v -coverprofile cover.cov ${PKG_LIST}

build:
	go env
	env GO111MODULE=on go build -ldflags '$(LDFLAGS)' -o bin/${PROJECT_NAME} ./*.go

release:
	env GO111MODULE=on GOOS=linux go build -ldflags '$(LDFLAGS)' -o bin/${PROJECT_NAME} ./*.go

clean:
	rm -f ./bin/${PROJECT_NAME}

lint:
	gometalinter --fast -t --errors --enable-gc ${GO_FILES}
