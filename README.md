# Installation

```
$ gem install rerun rack capistrano
$ bundle install
```

# Configuration

Setup database informations :

```
cp .env.example .env
```

open `.env` file and setup your mysql credentials

```
export DB_USERNAME=change_me
export DB_PASSWORD=change_me
```

Now create a database named `restful` and inject the sql file :

```
$ mysql restful < database.sql
```

Then you can run the development server by running :

```
$ ./dev_server.sh
```
