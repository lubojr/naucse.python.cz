## macOS installation of git

Try to run `git` on the command line.
If it's already installed, it will show you how to use it.
Otherwise, install it using Homebrew:

```console
brew install git
```

It is still necessary to set up your Git editor (enter `nano`,
even if you installed for example VS Code during the installation of the editor).
You do that with this command:

```console
git config --global core.editor nano
```

After that install and configure [Git Credential Manager](https://github.com/git-ecosystem/git-credential-manager/blob/release/docs/install.md#macos) with command:

```console
brew install --cask git-credential-manager
```

Now continue with the rest of setup at [General Settings in Git install]({{ lesson_url('git-en/install') }}).
