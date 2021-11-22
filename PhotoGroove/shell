#! /bin/bash

echo "-------------------------------------------------------"
echo "Please select a number of program what you want to run."
echo "    1) elm repl"
echo "    2) elm-format"
echo "    3) elm reactor"
echo "    4) elm make"
echo "    5) elm-live"
echo "    6) http-server"
echo "    7) json-server"
echo "    q) Quit this program"
echo "-------------------------------------------------------"


while read line
do
    case $line
    in
        1)
            echo "elm repl"
            npm run repl
            ;;
        2)
            echo "elm-format"
            npm run format
            ;;
        3)
            echo "elm reactor"
            npm run reactor
            ;;
        4)
            echo "elm make"
            npm run make
            ;;
        5)
            echo "elm-live"
            npm run live
            ;;
        6)
            echo "http-server"
            npm run http-server
            ;;
        7)
            echo "json-server"
            npm run json-server
            ;;
        [Qq]*)
            echo "Quit this program"
            break
            ;;

    esac

    echo "-------------------------------------------------------"
    echo "Please select a number of program what you want to run."
    echo "    1) elm repl"
    echo "    2) elm-format"
    echo "    3) elm reactor"
    echo "    4) elm make"
    echo "    5) elm-live"
    echo "    6) http-server"
    echo "    7) json-server"
    echo "    q) Quit this program"
    echo "-------------------------------------------------------"

done < ${1:-/dev/stdin}

