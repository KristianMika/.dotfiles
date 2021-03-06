.PHONY: all
all: git vim clang-format tmux zsh vscode

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

vim:
	cp --interactive .vimrc ~/.vimrc

clang-format:
	cp --interactive .clang-format ~/.clang-format

tmux:
	cp --interactive .tmux.conf ~/.tmux.conf

zsh: guard-DEBEMAIL guard-DEBFULLNAME
	envsubst '$${DEBEMAIL},$${DEBFULLNAME}' < .zshrc.in > .zshrc
	mv --interactive .zshrc ~/.zshrc
	mkdir -p "~/.zsh"
	git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
	git clone https://github.com/sindresorhus/pure.git "~/.zsh/pure"

vscode:
	`cat vscode-extensions.txt | xargs -L 1 echo code --install-extension`

clean:
	rm -f .zshrc .gitconfig