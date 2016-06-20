THISDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

mkdir -p ${FALCON_PREFIX}/bin

cat << EOF > ${THISDIR}/config.mk
FALCON_INSTALL_RULE=install
FALCON_PIP_EDIT=
FALCON_PIP_USER=
FALCON_PREFIX=${FALCON_PREFIX}
FALCON_WORKSPACE=${FALCON_WORKSPACE}

#export FALCON_WORKSPACE
#export FALCON_PREFIX
#export FALCON_PIP_EDIT
#export FALCON_PIP_USER
#export FALCON_INSTALL_RULE
EOF

echo 'You might still need to modify or remove easy-install.pth from site-packages/'
