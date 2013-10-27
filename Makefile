MODULESDIR=./node_modules
BINDIR=${MODULESDIR}/.bin

test-unit-back:
	@${BINDIR}/mocha $(path)

test: test-unit-back

load-fixtures:
	curl -XPOST http://localhost:4000/testing/fixtures

drop-test-db:
	curl -XPOST http://localhost:4000/testing/drop

test-func:
	ciao $(path) -c test/functional/cookies.json

create-cookies:
	@${BINDIR}/coffee test/functional/init.coffee;

test-func-init: drop-test-db load-fixtures create-cookies test-func

.PHONY: test-unit-back test load-fixtures drop-test-db test-func create-cookies test-func-init
