THISDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

mkdir -p ${FALCON_PREFIX}/bin

cat << EOF > ${THISDIR}/config.mk
FALCON_INSTALL_RULE=symlink
FALCON_PIP_EDIT=--edit
FALCON_PIP_USER=--user
FALCON_PREFIX=${FALCON_PREFIX}
FALCON_WORKSPACE=${FALCON_WORKSPACE}
PATH=${PYTHONUSERBASE}/bin:${PATH}

#export FALCON_WORKSPACE
#export FALCON_PREFIX
#export FALCON_PIP_EDIT
#export FALCON_PIP_USER
#export FALCON_INSTALL_RULE
EOF
