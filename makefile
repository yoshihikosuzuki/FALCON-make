FALCON_WORKSPACE?=..
FALCON_PREFIX?=../fc_env
VDIR:=${FALCON_PREFIX}
export CC=gcc
export CXX=g++

install: install-DAZZ_DB install-DALIGNER install-pypeFLOW install-FALCON
install-DAZZ_DB:
	${MAKE} -C ${FALCON_WORKSPACE}/DAZZ_DB
	cd ${FALCON_WORKSPACE}/DAZZ_DB; ln -sf $$PWD/DBrm $$PWD/DBshow $$PWD/DBsplit $$PWD/DBstats $$PWD/DBdust $$PWD/DBdump $$PWD/fasta2DB $$PWD/DB2fasta $$PWD/rangen ${VDIR}/bin/
install-DALIGNER: install-DAZZ_DB
	${MAKE} -C ${FALCON_WORKSPACE}/DALIGNER
	cd ${FALCON_WORKSPACE}/DALIGNER; ln -sf $$PWD/daligner $$PWD/daligner_p $$PWD/DB2Falcon $$PWD/HPC.daligner $$PWD/LA4Falcon $$PWD/LAmerge $$PWD/LAsort $$PWD/LAcat $$PWD/LAshow $$PWD/LAdump $$PWD/LAcheck $$PWD/LAindex  ${VDIR}/bin
install-pypeFLOW:
	which python
	cd ${FALCON_WORKSPACE}/pypeFLOW; pip install -e .
	python -c 'import pypeflow.common; print pypeflow.common'
install-FALCON:
	cd ${FALCON_WORKSPACE}/FALCON; pip install -e .
	python -c 'import falcon_kit; print falcon_kit.falcon'
bootstrap:
	pip install --upgrade pip
	pip install Cython
	cd ${FALCON_WORKSPACE}/pbcommand; pip install -e .
	cd ${FALCON_WORKSPACE}/pbsmrtpipe; pip install -e .
	# And for good measure
	pip install numpy
	pip install h5py
test: #after 'install'
	${MAKE} -C ${FALCON_WORKSPACE}/FALCON-examples test
# 'clean' operates on the repo dirs, not necessarily fc_env.
clean:
	cd ${FALCON_WORKSPACE}/DAZZ_DB; ${MAKE} clean
	cd ${FALCON_WORKSPACE}/DALIGNER; ${MAKE} clean
	cd ${FALCON_WORKSPACE}/pypeFLOW; python setup.py clean; rm -rf build/ dist/
	cd ${FALCON_WORKSPACE}/FALCON; python setup.py clean; rm -rf build/ dist/
