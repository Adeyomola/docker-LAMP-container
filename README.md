## HOW TO USE THIS COMPOSE FILE:
* After cloning the repo locally, create a directory named secrets in the local repo. Then create the following files:
~~~~
mkdir secrets && cd secrets && touch mysql_user mysql_db mysql_password mysql_root
~~~~
* In the `mysql_user` file, enter your db username. `echo username > mysql_user`
* In the `mysql_db` file, enter the name of the database. `echo database > mysql_db`
* In the `mysql_password` file, enter your user password.  `echo password > mysql_password`
* In the `mysql_root` file, enter your root password.  `echo rootpassword > mysql_root`
~~~~
echo username > mysql_user && echo database > mysql_db && echo password > mysql_password && echo rootpassword > mysql_root
~~~~
**NOTE: Docker secrets is more appropriate for storing secrets. The method above is merely illustrative.** 

Once your secrets are ready, run:
~~~~
docker compose build && docker compose up -d
~~~~

The web server listen's on port 80 and forwards to the docker host's port 8090. So, to test the app, go to:
`http://url:8090`
