# FALCON-make
This is one way to install the FALCON packages from a FALCON-workspace.

## Usage
We recommend using `virtualenv`.
```
export FALCON_PREFIX=${PWD}/fc_env
virtualenv --no-site-packages  --always-copy   ${FALCON_PREFIX}
. ${FALCON_PREFIX}/bin/activate
```
Then, install everything there.
```
git clone git://github.com/pb-cdunn/FALCON-install.git
git clone git://github.com/pb-cdunn/FALCON-workspace.git
export FALCON_WORKSPACE=${PWD}/FALCON-workspace
cd FALCON-install
make
```
After that, you can re-make at any time. The latest build will be in your `$PATH`.

# About the [LICENSE](LICENSE)
Standard PacBio "Open Source License".
