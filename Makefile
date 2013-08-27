MODULESDIR=./node_modules
BINDIR=${MODULESDIR}/.bin

test-unit-back:
	@${BINDIR}/mocha $(path)

test: test-unit-back

.PHONY: test-unit-back test
