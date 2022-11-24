## Git installation on Ubuntu/Debian

```console
$ sudo apt-get install git git-gui nano
```

If you are using some other distribution we expect that you already know
how to install programs. Go ahead and install *git*, *git gui* and *nano*.

After you have installed git, choose your Git editor.
If you do not like Vim (or you do not know what it is)
enter this command to choose a more user-friendly editor called Nano:

```console
$ git config --global core.editor nano
```

After this step, please install the [Git Credential Manager](https://github.com/GitCredentialManager/git-credential-manager) by downloading gcmcore-linux.(version).deb package from [official releases of gcm](https://github.com/GitCredentialManager/git-credential-manager/releases/latest).

After that install and configure with commands:

```console
$ sudo dpkg -i <path-to-package>
$ git-credential-manager-core configure
$ git config --global credential.credentialStore secretservice
```

Now continue with [General Settings in Git install]({{ lesson_url('git-en/install') }}).
