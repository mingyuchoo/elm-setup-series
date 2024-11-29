#!/bin/bash

echo "-------------------------------------------------------"
echo "Please select a number of program what you want to run."
echo "    1) Install package"
echo "    2) elm repl"
echo "    3) elm-format"
echo "    4) elm-live"
echo "    5) elm make"
echo "    q) Quit this program"
echo "-------------------------------------------------------"

while read line
do
    case $line
    in
        1)
            echo "Install package"
            elm install elm/http
            elm install elm/json
            elm install elm/random
            elm install krisajenkins/remotedata
            elm install NoRedInk/elm-json-decode-pipeline
            ;;
        2)
            echo "elm repl"
            elm repl
            ;;
        3)
            echo "elm-format"
            elm-format ./src --yes
            ;;
        4)
            echo "elm-live"
            elm-live --port 3000 ./src/Main.elm
            ;;
        5)
            echo "elm make"
            elm make src/Main.elm --optimize --output=public/dist/elm.js
            ;;
        [Qq]*)
            echo "Quit this program"
            break
            ;;

    esac

    echo "-------------------------------------------------------"
    echo "Please select a number of program what you want to run."
    echo "    1) Install package"
    echo "    2) elm repl"
    echo "    3) elm-format"
    echo "    4) elm-live"
    echo "    5) elm make"
    echo "    q) Quit this program"
    echo "-------------------------------------------------------"

done < ${1:-/dev/stdin}
