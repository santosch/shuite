#!/bin/bash

function composer {
    local executable="composer.phar"
    local command="php ${executable}"

    if ! [ -f ${executable} ]
    then
        echo -e "${COLOR_BLUE}Downloading composer-setup.php${COLOR_NO}"
        php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
        CHECKSUM="$(php -r 'copy("https://composer.github.io/installer.sig", "php://stdout");')"
        LOCAL_CHECKSUM="$(php -r "echo hash_file('sha384', 'composer-setup.php');")"

        if [ "$CHECKSUM" != "$LOCAL_CHECKSUM" ]
        then
            >&2 echo -e "${COLOR_RED}Installer checksum invalid!${COLOR_NO}"
            rm composer-setup.php
            exit 1
        fi

        php composer-setup.php --2
        EXIT=$?
        rm composer-setup.php

        if [[ $EXIT -ne 0 ]]
        then
          echo -e "${COLOR_RED}Composer setup failed${COLOR_NO}"
          exit 1
        fi

    else
        ${command} self-update --2
    fi

    ${command} "$@"
}

complete -W "dump-autoload install update require remove init search show validate --verbose" composer
