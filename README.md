## HOW TO USE THIS COMPOSE FILE:
* After cloning the repo locally, open the `.env.example` file and enter the appropriate database credentials.
* Make a copy of the `.env.example` file; the copy should be named .env `cp .env.example .env`
Once your `.env` file is ready, run:
~~~~
docker compose build && docker compose up -d
~~~~

The web server listen's on port 80 and forwards to the docker host's port 8090. So, to test the app, go to:
`http://url:8090` or `http://ipaddress:8090`
