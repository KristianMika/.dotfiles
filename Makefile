guard-%:
# checks if an environment variable is set - fails if it is not
# usage: guard-VARIABLE
	@ if [ "${${*}}" = "" ]; then \
		echo "Environment variable $* not set"; \
		exit 1; \
	fi

git: guard-GIT_EMAIL guard-GIT_NAME guard-GIT_SIGNKEY
	envsubst < .gitconfig.in > .gitconfig
	mv --interactive .gitconfig ~/.gitconfig
