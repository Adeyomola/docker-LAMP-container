HOW TO USE THIS COMPOSE FILE:
* After cloning the repo locally, create a directory named secrets in the cloned repo's directory.
* Inside the secrets directory, create the following files:
```touch mysql_user mysql_db mysql_password mysql_root```
* In the `mysql_user` file, enter your db username.
* In the `mysql_db` file, enter the name of the database.
* In the `mysql_password` file, enter your user password.
* In the `mysql_root` file, enter your root password.

Once your secrets are ready, run:
```docker compose build && docker compose up -d```
