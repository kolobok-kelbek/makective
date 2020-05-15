# Makective - Interactive for makefile

This is Makefile template appliation on PHP, Python or another web language in docker.

For example terminal output:

```
help: q - exit, j - down, k - up, l - select

 -> build:                Build all containers with docker-compose.yml  [shortcut: "b"]
    down:                 Stop and delete all containers and volumes with docker-compose.yml  [shortcut: "d"]
    help:                 Show help message  [shortcut: "h"]
    list:                 Show commands list  [shortcut: "l"]
    ps:                   Show containers list with docker-compose.yml []
    start:                Start all containers with docker-compose.yml []
    stop:                 Stop all containers with docker-compose.yml []
```