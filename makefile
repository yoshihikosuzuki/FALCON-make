-include config.mk
# Required:
#   FALCON_PREFIX
#   FALCON_WORKSPACE
# Optional:
#   FALCON_PIP_EDIT
#   FALCON_PIP_USER
#   FALCON_INSTALL_RULE (symlink or install)
#   PYTHONUSERBASE
FALCON_PIP_EDIT?=--edit
FALCON_INSTALL_RULE?=symlink
export CC=gcc
export CXX=g++

all: checklist
	${MAKE} show
	${MAKE} install-pip
	${MAKE} install
	${MAKE} check
checklist:
	@if [ -z "$${FALCON_PREFIX}" ]; then echo 'Error: FALCON_PREFIX is not set'; exit 1; fi
	@if [ ! -e "$${FALCON_PREFIX}/bin" ] ; then echo 'Error: directory FALCON_PREFIX/bin (${FALCON_PREFIX}/bin) does not exist'; exit 1; fi
install: install-DAZZ_DB install-DALIGNER install-DAMASKER install-DEXTRACTOR install-pypeFLOW install-FALCON install-git-sym install-minialign
install-DAZZ_DB:
	${MAKE} -C ${FALCON_WORKSPACE}/DAZZ_DB all
	PREFIX=${FALCON_PREFIX} ${MAKE} -C ${FALCON_WORKSPACE}/DAZZ_DB ${FALCON_INSTALL_RULE}
install-DALIGNER: install-DAZZ_DB
	${MAKE} -C ${FALCON_WORKSPACE}/DALIGNER all
	PREFIX=${FALCON_PREFIX} ${MAKE} -C ${FALCON_WORKSPACE}/DALIGNER ${FALCON_INSTALL_RULE}
install-DAMASKER:
	${MAKE} -C ${FALCON_WORKSPACE}/DAMASKER all
	PREFIX=${FALCON_PREFIX} ${MAKE} -C ${FALCON_WORKSPACE}/DAMASKER ${FALCON_INSTALL_RULE}
install-DEXTRACTOR:
	${MAKE} -C ${FALCON_WORKSPACE}/DEXTRACTOR all
	PREFIX=${FALCON_PREFIX} ${MAKE} -C ${FALCON_WORKSPACE}/DEXTRACTOR ${FALCON_INSTALL_RULE}
install-pypeFLOW:
	cd ${FALCON_WORKSPACE}/pypeFLOW; pip uninstall -v .; pip install -v ${FALCON_PIP_USER} ${FALCON_PIP_EDIT} .
install-FALCON: install-pypeFLOW
	cd ${FALCON_WORKSPACE}/FALCON; pip uninstall -v .; pip install -v ${FALCON_PIP_USER} ${FALCON_PIP_EDIT} .
install-FALCON_unzip: install-pypeFLOW
	cd ${FALCON_WORKSPACE}/FALCON_unzip; pip uninstall -v .; pip install -v ${FALCON_PIP_USER} ${FALCON_PIP_EDIT} .
install-git-sym:
	# TODO: copy vs. symlink?
	ln -sf $(abspath ${FALCON_WORKSPACE}/git-sym/git-sym) ${FALCON_PREFIX}/bin/git-sym
install-minialign:
	${MAKE} -C ${FALCON_WORKSPACE}/minialign all
	${MAKE} -C ${FALCON_WORKSPACE}/minialign PREFIX=${FALCON_PREFIX} install

install-pip:
	python -c 'import pip; print pip' || python get-pip.py ${FALCON_PIP_USER}
	pip install ${FALCON_PIP_USER} --upgrade pip
	pip install ${FALCON_PIP_USER} --upgrade setuptools # needed when --edit is used
show:
	mkdir -p ${FALCON_PREFIX}/bin
	which python
	echo "PYTHONUSERBASE=${PYTHONUSERBASE}"
	python -c 'import site; print site.USER_BASE'
	echo "FALCON_PIP_EDIT=${FALCON_PIP_EDIT}"
	echo "FALCON_PIP_USER=${FALCON_PIP_USER}"
check:
	python -c 'import pypeflow.simple_pwatcher_bridge; print pypeflow.simple_pwatcher_bridge'
	python -c 'import falcon_kit; print falcon_kit.falcon'
extra:
	pip install ${FALCON_PIP_USER} Cython
	pip install ${FALCON_PIP_USER} numpy
	pip install ${FALCON_PIP_USER} h5py
	cd ${FALCON_WORKSPACE}/pbcommand; pip install ${FALCON_PIP_USER} ${FALCON_PIP_EDIT} .
	cd ${FALCON_WORKSPACE}/pbsmrtpipe; pip install ${FALCON_PIP_USER} ${FALCON_PIP_EDIT} .
test: #after 'install'
	${MAKE} -C ${FALCON_WORKSPACE}/FALCON-examples test
clean:
	cd ${FALCON_WORKSPACE}/DAZZ_DB; ${MAKE} clean
	cd ${FALCON_WORKSPACE}/DALIGNER; ${MAKE} clean
	cd ${FALCON_WORKSPACE}/DAMASKER; ${MAKE} clean
	cd ${FALCON_WORKSPACE}/pypeFLOW; python setup.py clean; rm -rf build/ dist/
	cd ${FALCON_WORKSPACE}/FALCON; python setup.py clean; rm -rf build/ dist/
	cd ${FALCON_WORKSPACE}/minialign; ${MAKE} clean
