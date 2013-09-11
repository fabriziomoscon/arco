Arco
====

This project main goal is to provide an Open Public API to store and manage Archery scores.

We need you
-----------

Contributions are most welcome. If you care about archery and know how to build software you can help making progress to this exciting project. Ping me on github or Twitter if you have questins. Fork the this repository and start coding.


Setup
-----

In `~/.bash_profile` or equivalent:

```bash
export PATH=$PATH:./node_modules/.bin
export NODE_PATH=/usr/local/lib/node_modules:./
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
make test-unit-back path="test/unit/mapper/UserMapperTest.coffee"
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
