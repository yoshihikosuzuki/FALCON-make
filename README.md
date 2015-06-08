# FALCON-make
This is one way to install the FALCON packages from a FALCON-workspace.

## Set-up
We have some rules to get you started, but you might need to set that up yourself.
You can set `FALCON_PREFIX` and/or `FALCON_WORKSPACE` if you want, but the defaults will work.
```
git clone git://github.com/pb-cdunn/FALCON-install.git
git clone git://github.com/pb-cdunn/FALCON-workspace.git
cd FALCON-install

make pre

make virtualenv
```
If you want, activate the virtualenv. (Or let our makefile wrapper handle that for you.)
```
. ${FALCON_PREFIX}/bin/activate
```
## Build and install
Parallel builds should work fine.
```
make -j
```
After that, you can re-make at any time. The latest build will be in your `$PATH`.

# About the [LICENSE](LICENSE)
Standard PacBio "Open Source License".
