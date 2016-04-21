FALCON_WORKSPACE?=..
FALCON_PREFIX?=../fc_env
VDIR:=${FALCON_PREFIX}
export CC=gcc
export CXX=g++

install: build
	${MAKE} symlink
	# There is a race-condition when installing python, so we serialize.
	which python
	cd ${FALCON_WORKSPACE}/pypeFLOW; pip install -e .
	python -c 'import pypeflow.common; print pypeflow.common'
	cd ${FALCON_WORKSPACE}/FALCON; pip install -e .
	python -c 'import falcon_kit; print falcon_kit.falcon'
symlink:
	cd ${FALCON_WORKSPACE}/DAZZ_DB; ln -sf $$PWD/DBrm $$PWD/DBshow $$PWD/DBsplit $$PWD/DBstats $$PWD/DBdust $$PWD/DBdump $$PWD/fasta2DB $$PWD/rangen ${VDIR}/bin/
	cd ${FALCON_WORKSPACE}/DALIGNER; ln -sf $$PWD/daligner $$PWD/daligner_p $$PWD/DB2Falcon $$PWD/HPC.daligner $$PWD/LA4Falcon $$PWD/LAmerge $$PWD/LAsort $$PWD/LAcat $$PWD/LAshow $$PWD/LAdump $$PWD/LAcheck $$PWD/LAindex  ${VDIR}/bin
build: build-DAZZ_DB build-DALIGNER build-FALCON build-pypeFLOW
build-DAZZ_DB:
	${MAKE} -C ${FALCON_WORKSPACE}/DAZZ_DB
build-DALIGNER: build-DAZZ_DB
	${MAKE} -C ${FALCON_WORKSPACE}/DALIGNER
build-FALCON:
	cd ${FALCON_WORKSPACE}/FALCON; python setup.py build
build-pypeFLOW:
	cd ${FALCON_WORKSPACE}/pypeFLOW; python setup.py build
test: #after 'install'
	${MAKE} -C ${FALCON_WORKSPACE}/FALCON-examples test
# 'clean' operates on the repo dirs, not necessarily fc_env.
clean:
	cd ${FALCON_WORKSPACE}/DAZZ_DB; ${MAKE} clean
	cd ${FALCON_WORKSPACE}/DALIGNER; ${MAKE} clean
	cd ${FALCON_WORKSPACE}/pypeFLOW; python setup.py clean; rm -rf build/ dist/
	cd ${FALCON_WORKSPACE}/FALCON; python setup.py clean; rm -rf build/ dist/
