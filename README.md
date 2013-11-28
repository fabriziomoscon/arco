[![Build Status](https://travis-ci.org/fabriziomoscon/arco.png?branch=master)](https://travis-ci.org/fabriziomoscon/arco)

#Arco

`Arco` lets you run a server to store your archery scores. The server listens to `HTTP` and provides a RESTful Open Public API.

##Contributions

If you care about archery and know how to build software you can help making progress to this exciting project. Open an issue if you have questions. Fork the this repository and start contributing.

##Technologies

The server is a `node.js` application written mainly in CoffeeScript and it is based on `express.js`. The database is `mongoDB`.

##Philosophy

The project implementation follows the node.js phylosophy aggregating smaller library published on `npm` to achieve the final goal. It tries not to couple any library or service together. It requires minimal global installations to run.

##Dependencies

To run the server you need `mongoDB`, `redis` and `node.js` installed. For the full list or requirements see `package.json`,

type in the shell:

```bash
npm install
```
to install all local dependencies.

##Start Server

```bash
./set-env local npm run dev-api
```

testing modality
```bash
./set-env test npm run dev-api
```


##Testing

After each commit is pushed TravisCI starts testing as part of their Open Source cloud testing facility.

###On localhost
You can test a specific file like so:
```bash
./set-env test make && test-unit-back path="test/unit/mapper/UserMapperTest.coffee"
```

##Functional test

You need to install ciao globally to run the functional tests.
```bash
sudo npm install ciao -g
```

load fixtures
```bash
make drop-db
make load-fixtures
curl -XPOST http://localhost:4000/testing/fixtures/users
```

run the test

shell1
```bash
./set-env test npm run dev-api
```

shell2
```bash
make test-func path="test/functional/json/<RELATIVE_PATH_TO_TESTS>"
```
or drop and re-load fixtures
```bash
make test-func-init path="test/functional/json/<RELATIVE_PATH_TO_TESTS>"
```

##node.js version
To switch between different versions of node you can use `nave`
```bash
sudo nave usemain 0.10
```
