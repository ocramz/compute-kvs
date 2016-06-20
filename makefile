ACCOUNT = ocramz
PROJECT = compute-cluster-sandbox
TAG = $(ACCOUNT)/$(PROJECT)

.DEFAULT_GOAL := help

help:
	@echo "Use \`make <target>\` where <target> is one of"
	@echo "  help     to display this help message"
	@echo "  build  build Docker container"


build:
	docker build -t ${TAG} .
