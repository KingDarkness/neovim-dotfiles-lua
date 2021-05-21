#!/bin/bash
composer install --working-dir=formatter/php-cs-fixer
npm install --prefix formatter/prettier
npm install --prefix formatter/lua-ftm
curl -sS https://webinstall.dev/shfmt | bash
