## macOS installation of git

Try to run `git` on the command line.
If it's already installed, it will show you how to use it.
Otherwise, install it using Homebrew:

```console
$ brew install git
```

It is still necessary to set up your Git editor (enter `nano`,
even if you installed for example Atom during the installation of the editor).
You do that with this command:

```console
$ git config --global core.editor nano
```

After that install and configure [Git Credential Manager](https://github.com/GitCredentialManager/git-credential-manager) with commands:

```console
$ brew tap microsoft/git
$ brew install --cask git-credential-manager-core
```

Following should not be necessary anymore with newest versions of the GCM:

$ git config --global credential.credentialStore secretservice 

Now continue with [General Settings in Git install]({{ lesson_url('git-en/install') }}).
