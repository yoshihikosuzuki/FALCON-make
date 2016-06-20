# FALCON-make
These are some ways to install the FALCON packages from a FALCON workspace.

See *Installation* in the wiki.

# Types of installation
Python modules will be installed according to your environment,
and other executables will go into `${FALCON_PREFIX}/bin`, which
must already exist.

    mkdir -p ${FALCON_PREFIX}/bin

## Standard install
This is more permanent, not for developers. Python modules go into
your current site-packages, so you can run this within a **virtualenv**
for convenience, if you want.

Other executables are copied into `${FALCON_PREFIX}/bin` rather than symlinked.

```sh
bash config-standard.sh
```

## Development install
This is safest. We use `pip install --edit` so any changes in your Python
code are immediately reflected in your installation. Again, a
**virtualenv** is fine, if you want.

Other executables are installed into `${FALCON_PREFIX}/bin` as symbolic links.

```sh
bash config-edit.sh
```

## Development install into Python userbase
This is least likely to fail. Similar to the regular "development install",
we use `pip install --edit --user` so that
our FALCON Python modules remain at the front of your `sys.path`, but all updated
Python modules go into your current `site.USER_BASE`, which can be controlled
by `${PYTHONUSERBASE}`.

```sh
bash config-edit-user.sh
```

# Dependencies
All those installation types require `pip`.

## pip
If you do not have `pip` yet, we install
it for you via `make install-pip`.

* https://pip.pypa.io/en/stable/installing/

Behind a firewall, you might need to find another way to install `pip` yourself.

## Anaconda
It can be helpful to install Anaconda first, for a helpful
set of Python dependencies. If you do, remember to add
your new anaconda2/bin into your `$PATH` before proceeding.

* https://docs.continuum.io/anaconda/install

## extras
Some extra stuff can be installed via `make extra`

# Environment
We live this to you, but here are some ideas.

## PYTHONUSERBASE
We recommend that you export `PYTHONUSERBASE` before running `make`.
Otherwise, your build will (typically) be installed into `~/.local`
which is fine if you have only one installation.

* https://docs.python.org/2/library/site.html

## PATH
Before running tests, you need to add the new `bin` to your `PATH`.

    export PYTHONUSERBASE=$(python -c 'import site; print site.USER_BASE')
    export PATH=${PYTHONUSERBASE}/bin

# About the [LICENSE](LICENSE)
Standard PacBio "Open Source License".
