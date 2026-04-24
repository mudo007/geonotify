# geonotify
This project implements a platform in which events produced are sent as push to users obased on geolocation. The exaxt use cases will be defined later.

The main goal is to practice Go, Kafka, CI/CD and testing, while using an approach that keeps the architecture clean, scalable, modular, observable, and with DORA metrics built-in from the start.

Also, I added AI development workflow by versioning several agent-related .md files. 

Full disclosure: This project was seeded and incremented using Claude code, Gemnini and Codex.

# Instructions
This project is based on the premises that all development happens inside a docker container, so you don't need to install go on your machine. 
It also has "air" configured so that any changes saved locally will cause it to hot reload.
Also, when the project is checked-out, you need to run:
```
git config core.hooksPath .githooks
```
So that the pro-commit hooks (lint before commit) are run locally.

If you are on Mac OS, you will need to add this line to your ~/.zshrc. I don't know why zsh does not expose the UID environment variable to docker, thus we need this workaround. This is needed so that when docker runs mounting the local folder on it /app path, the files permissions are not changed, and the container does not run as root. Rember to re-source ~/.zshrc or open a new terminal afterwards.
```
export UID=$UID
```
In order to run the project just issue:
```
make up
```
And then wath the live logs with:
```
docker compose logs -f app
```
