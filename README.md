# FALCON-make
This is one way to install the FALCON packages from a FALCON workspace.

See *Installation* in the wiki.


## Anaconda
It can be helpful to install Anaconda first, for a helpful
set of Python dependencies. If you do, remember to add
your new anaconda2/bin into your `$PATH` before proceeding.

* https://docs.continuum.io/anaconda/install

## PYTHONUSERBASE
We recommend that you export `PYTHONUSERBASE` before running `make`.
Otherwise, your build will be installed into `../fc_env`.
(The typical default is `~/.local`,
which is fine if you have only one installation.)

* https://docs.python.org/2/library/site.html

## pip
We use `pip` here. If you do not have it yet, we install
it for you via `make bootstrap`.

* https://pip.pypa.io/en/stable/installing/

## extras
Some extra stuff can be installed via `make extra`

# About the [LICENSE](LICENSE)
Standard PacBio "Open Source License".
