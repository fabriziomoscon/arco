Arco
====

This project main goal is to provide an Open Public API to store and manage Archery scores.

We need you
-----------

Contributions are most welcome. If you care about archery and know how to program you can help making progress to the project. Ping me on github or Twitter if you have questins. Fork the this repository and start coding.


Setup
-----

In `~/.bash_profile` or equivalent:

```bash
export PATH=$PATH:./node_modules/.bin
export NODE_PATH=./:$NODE_PATH
```

From the command line:

```bash
npm install
```

```bash
[sudo] npm install -g supervisor
```

Start Server
------------

```bash
npm run supervisor
```

Browse localhost
-------------

[http://localhost:3000/](http://localhost:3000/)


Run Tests
---------

```bash
npm test
```

Functional test using ciao
--------------------------

install ciao globally
```bash
sudo npm install ciao -g
```

load fixtures
```bash
curl -XPOST http://localhost:4000/testing/drop
curl -XPOST http://localhost:4000/testing/fixtures
curl -XPOST http://localhost:4000/testing/fixtures/users
```

run the test

console1
```bash
npm run testing
```

console2 (JSON)
```bash
ciao test/functional/json -c test/functional/ciao.json
```

console3 (HTML)
```bash
ciao test/functional/html -c test/functional/ciao.json
```

ubuntu
------

In order to run nodejs on lower port without root permission the following has been installed and executed
```bash
sudo apt-get install libcap2-bin
sudo setcap cap_net_bind_service=+ep /usr/bin/nodejs
sudo setcap cap_net_bind_service=+ep  /usr/local/lib/node_modules/coffee-script/bin/coffee
```

In order to switch between different versions of node we installed nave which can be used easly with the following
```bash
sudo nave usemain 0.10
```

Start the server as a daemon:

```bash
nohup npm run supervisor >> /var/www/app.log 2>&1 &
```

Database
--------

You can access collections and documents inside the database installing smog on your local machine

```bash
[sudo] npm install smog -g
```

and executing it
```bash
smog &
```

once smog is running open a browser to [http://localhost:8080/](http://localhost:8080/) and change `test` to `arco` inside the DSN popup

NOTE

NODE_PATH='./:$NODE_PATH' and NODE_ENV='staging' must be in ~/.bashrc or exported in the current env

# Front-end

## Build environment

The front-end code is using [Jake] as a build tool.
Jake is installed by npm as one of the dev dependencies.
Jake can execute tasks from `Jakefile.coffee`.
Run `jake -T` to see a list of the available tasks.
Run `jake <task name>` to execute a task.
When a task depends on some other tasks,
those other tasks will be executed first.

## Style

CSS is compiled from Stylus code.
The Stylus middleware automatically recompiles
when changes are made.

## Updating CoffeeScript

There is a `watch` Jake task
that can be used to automatically
compile and bundle front-end CoffeeScript
when it is changed.

[jake]: https://github.com/mde/jake