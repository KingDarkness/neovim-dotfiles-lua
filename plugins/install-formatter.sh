#!/bin/bash
composer install --working-dir=$HOME/.config/nvim/plugins/formatter/php-cs-fixer
npm install --prefix $HOME/.config/nvim/plugins/formatter/prettier
npm install --prefix $HOME/.config/nvim/plugins/formatter/lua-ftm
curl -sS https://webinstall.dev/shfmt | bash
