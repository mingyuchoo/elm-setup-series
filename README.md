# elm-setup-series

## How to install

- <https://guide.elm-lang.org/install/elm.html>

### Create a project

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

### Generate `index.html` file from `Main`

```bash
elm make src/Main.elm
```

### Generate `elm.js` file from `Main`

```bash
elm make src/Main.elm --optimize --output=elm.js
```

## How to run

open `index.html` file with a `web browser`.


## References

- <https://guide.elm-lang.org/>


