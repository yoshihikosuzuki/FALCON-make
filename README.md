# FALCON-make
This is one way to install the FALCON packages from a FALCON workspace.

See *Installation* in the wiki.

## PYTHONUSERBASE
We recommend that you export `PYTHONUSERBASE` before running `make`.
Otherwise, your build will (typically) be installed into `~/.local`
which is fine if you have only one installation.

* https://docs.python.org/2/library/site.html

## PATH
Before running tests, you need to add the new `bin` to your `PATH`.

    export PYTHONUSERBASE=$(python -c 'import site; print site.userbase')
    export PATH=${PYTHONUSERBASE}/bin

## pip
We use `pip` here. If you do not have it yet, we install
it for you via `make bootstrap`.

* https://pip.pypa.io/en/stable/installing/

## Anaconda
It can be helpful to install Anaconda first, for a helpful
set of Python dependencies. If you do, remember to add
your new anaconda2/bin into your `$PATH` before proceeding.

* https://docs.continuum.io/anaconda/install

## extras
Some extra stuff can be installed via `make extra`

# About the [LICENSE](LICENSE)
Standard PacBio "Open Source License".
