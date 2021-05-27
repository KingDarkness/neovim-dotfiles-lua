#!/bin/bash
tput setaf 3
printf "%s\n" "install php-cs-fixer start"
composer install --working-dir=$HOME/.config/nvim/plugins/formatter/php-cs-fixer
tput setaf 2
printf "%s\n" "install php-cs-fixer success"

tput setaf 3
printf "%s\n" "install prettier start"
npm install --prefix $HOME/.config/nvim/plugins/formatter/prettier
tput setaf 2
printf "%s\n" "install prettier success"

tput setaf 3
printf "%s\n" "install lua-fmt start"
npm install --prefix $HOME/.config/nvim/plugins/formatter/lua-fmt
tput setaf 2
printf "%s\n" "install lua-fmt success"

tput setaf 3
printf "%s\n" "install shfmt start"
if ! command -v shfmt &>/dev/null; then
  curl -sS https://webinstall.dev/shfmt | bash
fi
tput setaf 2
printf "%s\n" "install shfmt success"

tput setaf 2
printf "%s\n" "install all formatter success"
