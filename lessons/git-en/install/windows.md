## Windows installation of git

Go to [git-scm.org](https://git-scm.org), download Git and install it.
When installing, select these options:

* Run Git from the Windows Command Prompt
* Checkout Windows-style, commit Unix-style line endings

Do not change any other options, they can be left as default.
Please ensure that **Git Credential Manager Core** option is ["checked"](https://github.com/GitCredentialManager/git-credential-manager#windows), to install the extra tool by default with Git installation.

Then set your Git editor.
If you have a terminal window open, close it, and open a new one.
(The installation changes system settings which have to be loaded again.)
In the new command line, enter:

```console
> git config --global core.editor notepad
> git config --global format.commitMessageColumns 80
> git config --global gui.encoding utf-8
```

Now continue with [General Settings in Git install]({{ lesson_url('git-en/install') }}).
