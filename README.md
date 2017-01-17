# Lorp Backend

Provides the backend services for a simple home automation platform. This software is experimental and not intended for production use.

## Install

The backend is written in elixir and uses the phoenix framework. To get started you will need to have working installations of both.

Assuming your system has all of the prerequisites, clone the repo and run the the following commands inside.

```
mix deps.get
```
Installs the required packages

```
mix ecto.create
```
Sets up the database

```
mix ecto.migrate
```

Runs migrations

```
mix phoenix.server
```

Starts the backend server on port 4000
