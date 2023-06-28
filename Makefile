.PHONY: all

VERSION = 2.6.2

all:
	docker build . --progress=plain --build-arg TESTCAFE_VERSION=$(VERSION)
