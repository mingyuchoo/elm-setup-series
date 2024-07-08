# 12-elm-mvc-pattern

## How to install

- <https://guide.elm-lang.org/install/elm.html>

### Create a project (for the first time)

```bash
mkdir <project-name>

cd <project-name>

elm init
```

### Install modules

```bash
elm install elm/http

elm install elm/json
```

## How to build

### Run Elm Dashboard at `http://localhost:8000`

```bash
elm reactor
```

### Generate `elm.js` file from `Main`

```bash
elm make src/Main.elm --optimize --output=main.js
```

## How to run in a web browser

open `index.html` file with a `web browser`.

## References

- <https://guide.elm-lang.org/>
