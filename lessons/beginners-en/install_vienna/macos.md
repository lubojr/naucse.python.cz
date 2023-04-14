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


**Note** - If you have an older versions of Mac OS X - for example 10.10.x, the newest versions of Python and VSCode will not work for you.

You will need to install an older version of both manually.

`Python`: https://legacy.python.org/download/mac/ will definitely lead you to a solution.

`VS Code`: For example January 2021 version of VS Code could solve it - refer to https://stackoverflow.com/a/67763370/7875133 for more details.
