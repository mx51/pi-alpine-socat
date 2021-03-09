#!/usr/bin/env make

.DEFAULT_GOAL := help

# COLORS
GREEN  := $(shell tput -Tvt100 setaf 2)
YELLOW := $(shell tput -Tvt100 setaf 3)
WHITE  := $(shell tput -Tvt100 setaf 7)
RED    := $(shell tput -Tvt100 setaf 1)
CYAN   := $(shell tput -Tvt100 setaf 6)
RESET  := $(shell tput -Tvt100 sgr0)

TARGET_MAX_CHAR_NUM := 20

###Help
## Show help
help:
	@echo ''
	@echo 'Usage:'
	@echo '  ${YELLOW}make${RESET} ${GREEN}<target>${RESET}'
	@echo ''
	@echo 'Targets:'
	@awk '/(^[a-zA-Z\-\.\_0-9]+:)|(^###[a-zA-Z]+)/ { \
		header = match($$1, /^###(.*)/); \
		if (header) { \
			title = substr($$1, 4, length($$1)); \
			printf "${CYAN}%s${RESET}\n", title; \
		} \
		helpMessage = match(lastLine, /^## (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")-1); \
			helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
			printf "  ${YELLOW}%-$(TARGET_MAX_CHAR_NUM)s${RESET} ${GREEN}%s${RESET}\n", helpCommand, helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)


