#! /bin/bash

elm install elm/http
elm install elm/json
elm make src/Main.elm --optimize --output=main.js

