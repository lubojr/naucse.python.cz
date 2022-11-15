# Python install for macOS

First check in your command line/terminal
if you don't already have python3 installed.
Open the terminal and type into it:

```console
$ python3 --version
```
If "Python" and version number (e. g. `Python 3.8.2`) will appear
and the version is higher than or equal to 3.8 then everything is fine and please continue with
further section.

If not, then please install [Homebrew](http://brew.sh) which makes app and modules installation
much easier.

First check if brew is already installed by:
```console
brew -v
```

If previous command did not return a installed brew version, install it by entering this command in the command line/terminal:

```console
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

And then you can just enter this command:

```console
$ brew install python3
```

Typing *python3 --version* again should already return you a used version of Python.
