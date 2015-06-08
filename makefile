FALCON_WORKSPACE?=../FALCON_WORKSPACE
FALCON_PREFIX?=../fc_env
VDIR:=${FALCON_PREFIX}

install: install-DAZZ_DB install-DALIGNER install-pypeFLOW install-FALCON
install-DAZZ_DB:
	cd ${FALCON_WORKSPACE}/DAZZ_DB; ${MAKE}; ln -sf $$PWD/DBrm $$PWD/DBshow $$PWD/DBsplit $$PWD/DBstats $$PWD/fasta2DB ${VDIR}/bin/
install-DALIGNER:
	cd ${FALCON_WORKSPACE}/DALIGNER; ${MAKE}; ln -sf $$PWD/daligner $$PWD/daligner_p $$PWD/DB2Falcon $$PWD/HPCdaligner $$PWD/LA4Falcon $$PWD/LAmerge $$PWD/LAsort $$PWD/LAcat $$PWD/LAshow  ${VDIR}/bin
install-pypeFLOW:
	cd ${FALCON_WORKSPACE}/pypeFLOW; python setup.py install
install-FALCON:
	cd ${FALCON_WORKSPACE}/FALCON; python setup.py install
# 'clean' operates on the repo dirs, not necessarily fc_env.
clean:
	cd ${FALCON_WORKSPACE}/DAZZ_DB; ${MAKE} clean
	cd ${FALCON_WORKSPACE}/DALIGNER; ${MAKE} clean
	cd ${FALCON_WORKSPACE}/pypeFLOW; python setup.py clean
	cd ${FALCON_WORKSPACE}/FALCON; python setup.py clean
