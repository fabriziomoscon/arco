[![Build Status](https://travis-ci.org/fabriziomoscon/arco.png?branch=master)](https://travis-ci.org/fabriziomoscon/arco)

Arco
====

`Arco` provides an Open Public API to store and manage individual Archery scores.


We need you
-----------

Contributions are most welcome. If you care about archery, know how to build software you can help making progress to this exciting project. Open an issue if you have questions. Fork the this repository and start contributing.


Technologies
------------
The core of the API is written in CoffeeScript and runs a node.js app based on `express.js`. The database is `mongoDB`


Philosophy
----------
This project implementation follows the node.js phylosophy. It aggregates smaller library with `npm` to do the job. It will never couple any library or service. Require minimal global installations.

Setup
-----

It requires `mongoDB`, `redis` and `node.js` installed. For the full list or requirements see `package.json`

From terminal:

```bash
npm install
```

Start Server
------------

```bash
./set-env local npm run dev-api
```

testing modality
```bash
./set-env test npm run dev-api
```


Browse localhost
-------------

[http://localhost:3000/](http://localhost:3000/)


Run Tests
---------

```bash
./set-env test make test-unit-back path="test/unit/mapper/UserMapperTest.coffee"
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

terminal1
```bash
npm run testing
```

terminal2 (JSON)
```bash
ciao test/functional/json -c test/functional/ciao.json
```

terminal3 (HTML)
```bash
ciao test/functional/html -c test/functional/ciao.json
```

To switch between different versions of node you can use `nave`
```bash
sudo nave usemain 0.10
```
