# Setting up on Divio/Railway

The setup guide is currently in work-in-progress mode
and may update without notice. Controbutions are welcome!

## Installing required dependencies

* Optional dependency: (not required, but may suit your use case)
  * Official GitHub CLI: <https://github.com/cli/cli/blob/trunk/docs/install_linux.md> (requires Android 7+ and latest Termux app version from F-droid)
* For Linux users:
  * Git: see <https://git-scm.com/download/linux> for most distros, `pkg install git` for Termux
  * Python3 (3.7 or above is better): see <https://fossbytes.com/install-python-on-linux/> to use your distro's preferred package manager or <https://opensource.com/article/20/4/install-python-linux> to build from tarball and manually update anytime, `pkg install python` for Termux
  * OpenSSL: follow along <https://www.howtoforge.com/tutorial/how-to-install-openssl-from-source-on-linux/> to build from source or check with your distro's docs for details, `pkg install openssl-tool` for Termux.
  * OpenSSH: <https://www.tecmint.com/install-openssh-server-in-linux/> for deb/rpm-based distros or check with your distro's docs, `pkg install openssh` for Termux
* For macOS: (assuming [Homebrew](https://docs.brew.sh/Installation) is installed):
  * Git: `brew install git`
  * Python: `brew install python@3`
  * OpenSSL: `brew install openssl`
  * OpenSSH: `brew install openssh`
* For Windows (assuming Windows 10, WSL users should follow Linix section above)
  * Git: (please use Git Bash as you follow the steps below as I'm working on Powershell script soon)
  * Python:
  * OpenSSL
  * OpenSSH

## Installing on Divio

### Phase 1: Project Init

You need Git, Python3 (for `divio-cli` package), OpenSSL (for Termux Android app users,
the `openssl-tool` APT package is also required) and OpenSSH installed on the machine.

1. [Fork the repo first](https://github.com/AndreiJirohHaliliDev2006/bitwardenrs-on-divio/fork).
   * If the official GitHub CLI is ibstalled, you can fork from the command line with `gh repo fork AndreiJirohHaliliDev2006/bitwardenrs-on-divio`.

2. Clone your fork into your machine with `git clone https://github.com/YOUR-USERNAME/bitwardenrs-on-divio.git`.
   * To also configure the upstream remote for official GH CLI users, do `gh repo clone YOUR-USERNAME/bitwardenrs-on-divio`.

3. Install the Divio CLI with `pip3 install -U divio-cli --upgrade`
   * For Windows users, replace `pip3` with `pip` if Python 3.x is only installed.

4. Login to [Divio Control Panel](https://control.divio.com) then copy your API token in the [Access Token page](https://control.divio.com/account/desktop-app/access-token/).
   * To fetch/pull/push to and from the Git repo or access the server through SSH, you need to add your SSH key to your account. [Read this guide](https://support.divio.com/how-to/setup-ssh-key/) on how to add your SSH keys.

5. [Create a new project](https://control.divio.com/control/project/create/). When prompted to choose an subscription, leave the defaults and hit Save.

6. Go back to your terminal window and do `divio login [PASTE-YOUR-ACCESS-KEY-HERE]`

7. Navigate into your local copy of your fork with `cd bitwardenrs-on-divio` (may depends on how you clone and where).

8. Run `divio project configure`, press `y` then hit Enter. Then type your new project's slug and hit Enter.
You may notice some text simliar to these below after hitting Enter.
Now, copy your Git remote and run `git remote add divio [YOUR-DIVIO-GIT-REMOTE-HERE]`.
```
This action will overwrite the local Divio configuration file for your project or create a new one. Do you want to continue? [y/N]: y
Please enter the application slug of the local project: bitwardenrs-thepinsteam
Configuration file: /data/data/com.termux/files/home/bitwardenrs_heroku/.divio/config.json
Git remote:         git@git.divio.com:bitwardenrs-thepinsteam.git
```

9. Run the `tools/setup-bwrs-instance` script with `divio` argument.
   * You may prompted to re-enter your Divio API key because it doesn't rely on the `~/.netrc` file on your drive for security reasons.
   * This might take some while because the script is actively interacting with the API.
   * Once the provisioning of the Postgrrs database is completed, follow the prompts to complete the setup.

10. Upon reaching this message below, run the `tools/push2divio` to push to its Git repository and deploy.

```
==========================================================
The setup was completed successfully. To finish the
deployment and to access the Bitwarden Web Vault,
run the following command to deploy to Divio:

  $ ./tools/push2divio

This will force-push into your project's Git repository
and then run `divio project deploy`.

If you ever need to update your BitwardenRS instance, run
the following command to issue an image rebuild:

  $ ./tools/update-instance divio

Enjoy your new BitwardenRS instance!
==========================================================
```

11. Congrats! You successfully deployed an BitwardenRS instance
on Divio.

## Installing on Railway

> **WORK IN PROGRESS**

1. Fire up the deployment page by pressing the button below.

[![Deploy on Railway](https://railway.app/button.svg)](https://railway.app/new?template=https%3A%2F%2Fgithub.com%2FAndreiJirohHaliliDev2006%2Fbitwardenrs-on-divio&plugins=postgresql&envs=RAILWAY%2CDOMAIN%2CADMIN_TOKEN%2CENABLE_ADMIN%2CSMTP_FROM&optionalEnvs=DOMAIN%2CADMIN_TOKEN&RAILWAYDesc=Special+env+var+for+error+messages+and+logs&DOMAINDesc=If+using+custom+domain%2C+please+fill+it+with+the+https%3A%2F%2F+prefix.+%28e.g.+https%3A%2F%2Fvault.madebythepins.tk%29+Otherwise%2C+leave+it+blank&ADMIN_TOKENDesc=If+enabled%2C+enter+a+new%2C+uqinue+password.+Generate+with+%27openssl+rand+-base64+48%27+or+Bitwarden%27s+password+generator.&ENABLE_ADMINDesc=Set+to+true+to+enable%2C+otherwise+set+to+false.&RAILWAYDefault=true)

2. Fill up the required missing fields. Don't forget to set
`MAKE_IT_FAIL` to any value so the startup script will fail
artifically instead of complaining about missing required
configuration such as SMTP settings and domain name on your
runtime logs.

3. Open your terminal and clone your hard-forked repo with `gh repo clone YOUR-USERNAME/bitwardenrs-on-divio`
(if GitHub CLI is not installed try `git clone git@github.com:YOUR-USERNAME/bitwardenrs-on-divio.git`.

4. Navigate into your local copy of your fork with `cd bitwardenrs-on-divio` (may depends on how you clone and where).

5. Run `./tools/setup-bwrs-instance railway` to install the CLI and connect your local repo to the newly-created project,
among other things.
   * The script will set `MAKE_IT_FAIL` to `false` after completing the setup wizard.

## Troubleshooting

* Can't install Railway CLI on Termux?
  * Railway CLI is currently only work on Linux, macOS and Windows. Probably try following the setup
guide on an cloud dev environment like Gitpod.
