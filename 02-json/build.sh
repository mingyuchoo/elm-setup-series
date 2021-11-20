#! /bin/bash

elm install elm/http
elm install elm/json
elm install elm/random
elm install krisajenkins/remotedata
elm install NoRedInk/elm-json-decode-pipeline
elm make src/Main.elm --optimize --output=main.js

