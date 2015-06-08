# FALCON-make
This is one way to install the FALCON packages from a FALCON-workspace.

* For simplicity, run this via FALCON-integrate. (See https://github.com/pb-cdunn/FALCON-integrate for details.)
* You can set `FALCON_PREFIX` and/or `FALCON_WORKSPACE` if you want, but the defaults will work.
* You can use this package directly if you follow these directions.

## Set-up

* You will need an active **virtualenv**.

```
export FALCON_PREFIX=../fc_env
mkdir -p ${FALCON_PREFIX}
virtualenv -p $(shell which python2.7) --no-site-packages  --always-copy ${FALCON_PREFIX}
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
