#!/bin/bash
composer install --working-dir=~/.config/nvim/plugins/formatter/php-cs-fixer
npm install --prefix ~/.config/nvim/plugins/formatter/prettier
npm install --prefix ~/.config/nvim/plugins/formatter/lua-ftm
curl -sS https://webinstall.dev/shfmt | bash
