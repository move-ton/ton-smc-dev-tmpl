#########################################################################
# Setup env
#########################################################################

BIN:=~/bin
SOLC:=$(BIN)/solc
LIB:=$(BIN)/stdlib_sol.tvm
LINKER:=$(BIN)/tvm_linker

#########################################################################
# Compile and link
#########################################################################

CONTRACTS:=Launchpad
TVCS:=$(patsubst %, tvc/%.tvc,$(CONTRACTS))

clean:
	rm -rf tvc/*.tvc
	rm -rf abi/*.abi.json
	rm data/*.addr
	rm data/*.json
	rm data/keys/*.json

dirs:
	mkdir -p abi tvc

compile: dirs $(TVCS)
	echo $^

tvc/%.tvc: src/%.sol
	$(SOLC) $^ -o src
	
	$(LINKER) compile --lib $(LIB) src/$*.code -a src/$*.abi.json -o $@
	mv src/$*.abi.json abi
	mv src/$*.code code stateInit
	rm -rf src/$*.code

#########################################################################
# Deploy
#########################################################################

setup: compile
	-python scripts/not.py $(net) setup

give: dumpenv
	-python scripts/not.py $(net) giver launchpad 10

upload: setup
	-python scripts/not.py $(net) upload

upgrade: setup
	-python scripts/not.py $(net) upgrade

deploy: upload
	-python scripts/not.py $(net) deploy 1

#########################################################################
# Dump system contracts addresses
#########################################################################

dumpenv: setup
	-python scripts/dumpenv.py $(net)
