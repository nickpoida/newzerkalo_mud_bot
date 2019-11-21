#!/bin/bash
username="Имя игрока с большой буквы"
password="Пароль"
leader="Имя лидера с большой буквы"
coproc nc { nc newzerkalo.virtustan.tk 4000; }

while [[ $nc_PID ]] && IFS= read -r -u${nc[0]} line; do
    case $line in
        (*'UTF-8'*)
            printf >&${nc[1]} '%s\n' '5'
            ;;
        (*'Наш сайт'*)
            printf >&${nc[1]} '%s\n' "$username $password"
            ;;
        (*'Последний раз вы заходили'*)
            printf >&${nc[1]} '%s\n' "ик"
            ;;
        (*"$leader сообщил группе : '$username"*)
            botaction=${line#*"$leader сообщил группе : '$username"}
            botactdel=${botaction%"'"*}
            printf >&2 '%s\n' "Sent line:" "$botactdel"
            printf >&${nc[1]} '%s\n' "$botactdel"
            ;;
        (*)
            printf >&2 '%s\n' "Received line:" "$line"
            ;;
    esac
done
