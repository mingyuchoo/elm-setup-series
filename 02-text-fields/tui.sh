#! /bin/bash

echo "-------------------------------------------------------"
echo "Please select a number of program what you want to run."
echo "    1) Install package"
echo "    2) Elm repl"
echo "    3) elm-format"
echo "    4) Elm make"
echo "    5) elm-live"
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
            echo "Elm repl"
            elm repl
            ;;
        3)
            echo "elm-format"
            elm-format ./src --yes
            ;;
        4)
            echo "Elm make"
            elm make src/Main.elm --optimize --output=main.js
            ;;
        5)
            echo "elm-live"
            elm-live ./src/Main.elm
            ;;
        [Qq]*)
            echo "Quit this program"
            break
            ;;

    esac

    echo "-------------------------------------------------------"
    echo "Please select a number of program what you want to run."
    echo "    1) Install package"
    echo "    2) Elm repl"
    echo "    3) elm-format"
    echo "    4) Elm make"
    echo "    5) elm-live"
    echo "    q) Quit this program"
    echo "-------------------------------------------------------"

done < ${1:-/dev/stdin}

