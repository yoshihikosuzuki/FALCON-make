FALCON_WORKSPACE?=..
export CC=gcc
export CXX=g++
#export PYTHONUSERBASE?=../fc_env
export PYTHONUSERBASE?=$(shell python -c 'import site; print site.USER_BASE')
export PATH:=${PYTHONUSERBASE}/bin:${PATH}
PREFIX:=${PYTHONUSERBASE}
VDIR:=${PREFIX}

${PREFIX}/bin:
	mkdir -p $@
install: install-DAZZ_DB install-DALIGNER install-DAMASKER install-pypeFLOW install-FALCON install-git-sym| ${PREFIX}/bin
install-DAZZ_DB:
	${MAKE} -C ${FALCON_WORKSPACE}/DAZZ_DB all
	PREFIX=${VDIR} ${MAKE} -C ${FALCON_WORKSPACE}/DAZZ_DB symlink
install-DALIGNER: install-DAZZ_DB
	${MAKE} -C ${FALCON_WORKSPACE}/DALIGNER all
	PREFIX=${VDIR} ${MAKE} -C ${FALCON_WORKSPACE}/DALIGNER symlink
install-DAMASKER:
	${MAKE} -C ${FALCON_WORKSPACE}/DAMASKER all
	PREFIX=${VDIR} ${MAKE} -C ${FALCON_WORKSPACE}/DAMASKER symlink
install-pypeFLOW:
	which python
	cd ${FALCON_WORKSPACE}/pypeFLOW; pip install -v --user --edit .
	python -c 'import pypeflow.common; print pypeflow.common'
install-FALCON: install-pypeFLOW
	cd ${FALCON_WORKSPACE}/FALCON; pip install -v --user --edit .
	python -c 'import falcon_kit; print falcon_kit.falcon'
install-git-sym:
	ln -sf $(abspath ${FALCON_WORKSPACE}/git-sym/git-sym) ${PYTHONUSERBASE}/bin/git-sym
bootstrap:
	echo ${PYTHONUSERBASE}
	python -c 'import site; print site.USER_BASE'
	which pip || python get-pip.py --user
	pip install --user --upgrade pip
check:
	which python
	which pip
extra:
	pip install --user Cython
	pip install --user numpy
	pip install --user h5py
	cd ${FALCON_WORKSPACE}/pbcommand; pip install --user --edit .
	cd ${FALCON_WORKSPACE}/pbsmrtpipe; pip install --user --edit .
test: #after 'install'
	${MAKE} -C ${FALCON_WORKSPACE}/FALCON-examples test
# 'clean' operates on the repo dirs, not necessarily fc_env.
clean:
	cd ${FALCON_WORKSPACE}/DAZZ_DB; ${MAKE} clean
	cd ${FALCON_WORKSPACE}/DALIGNER; ${MAKE} clean
	cd ${FALCON_WORKSPACE}/DAMASKER; ${MAKE} clean
	cd ${FALCON_WORKSPACE}/pypeFLOW; python setup.py clean; rm -rf build/ dist/
	cd ${FALCON_WORKSPACE}/FALCON; python setup.py clean; rm -rf build/ dist/
