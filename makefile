# We suggest that you not add any rules here. Instead, customize `install.makefile`.

FALCON_PREFIX?=$(abspath fc_env)
FALCON_WORKSPACE?=$(abspath ../FALCON-workspace)
export FALCON_PREFIX
export FALCON_WORKSPACE

install:

# Activate virtualenv environment and delegate the rule to `install.makefile`.
%:
	 . ${FALCON_PREFIX}/bin/activate; ${MAKE} -f install.makefile $@

# These can be helpful for setup.
pre:
	cd ${FALCON_WORKSPACE}; git submodule init; git submodule update
virtualenv:
	mkdir -p ${FALCON_PREFIX}
	virtualenv -p $(shell which python2.7) --no-site-packages  --always-copy ${FALCON_PREFIX}
check:
	. ${FALCON_PREFIX}/bin/activate; which python
