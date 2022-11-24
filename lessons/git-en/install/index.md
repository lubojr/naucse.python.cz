# Git

There is another program that we will install and that will later let us cooperate
and develop programs together with other people. It's called [Git](https://git-scm.com/).
Let's install it and set it up.

On some operating systems, for convenience, we shall also install [Git Credential Manager](https://github.com/GitCredentialManager/git-credential-manager)

Choose a page depending on your operating system:

* [Linux]({{ subpage_url('linux') }})
* [Windows]({{ subpage_url('windows') }})
* [macOS]({{ subpage_url('macos') }})

After you finish installation of `git` return back here to finish the next part **Settings**.

## Settings

Several people can collaborate in one project in Git.
To track who make a specific change, we need to
tell Git our name and e-mail.
At the command prompt, enter the following commands, but change the
name and address to yours:

```console
$ git config --global user.name "Jane Berry"
$ git config --global user.email jane.berry@example.com
```

You can of course use a nickname or even
fake email, but then it will be more complicated to
engage in team projects.
Anyway, your name and email can be changed at any time
by typing the configuration commands again.

> [note]
> If you are afraid of spam, do not worry.
> Your e-mail address can be viewed only by people who download the project
> to which you contributed.
> Spammers mostly focus on less technically capable people than Git users. :)

You can also set up color listings - if you don't think
(like some Git authors) that the command line should be black and white:

```console
$ git config --global color.ui true
```

> [note]
> Running `git config` does not print any message that the operation was successful.
> This is normal; many other commands behave like that, for example `cd`.
>
> You can check your current git configuration with the command:
>
> ```console
> $ git config --global --list
> user.name=Jane Berry
> user.email=jane.berry@example.com
> ```

And that's all! You have installed and configured `Git`.

**Congratulations!**
