# Vaultwarden on any Dockerfile-supported PaaS

Run [Vaultwarden](https://github.com/dani-garcia/vaultwarden) on supported PaaS platforms where Dockerfiles are supported.

Based on official Vaultwarden docker image and also hard-forked
from the original [bitwardenrs_heroku](https://github.com/std2main/bitwardenrs_heroku)
repo, I added customized scripts to setup and manage in both Divio and Railway enviroments.

## Goal

* Deploy a reliable Vaultwarden instance for free as easy as possible.
* Deploying one requires basic command line skills. You'll be guided through the setup guide.
* Maintainance: Almost zero, as long as you keep it up to date.
* As more functions as budget support
  1. Essentials and backups: Most PaaS services have some sort of backup options, but only the database is usually backed up. You can always manually backup if you want.
  2. Icons: They'll always pulled on startup for new deploys. You can optionally disable it in the `vaultwarden-startup` file.
  3. TODO: Realtime syncing cross multiple devices. This requires Nginx setup chaos.
  4. TODO: Attachments. Since containers don't usually keep files once destoryed, we may consider doing some AWS S3 magic soon. (Speaking of setting this up on an Kubernetes-centric PaaS services like Okteto Cloud, we'll working on to add one soon.)
* And to test-run Vaultwarden, an Docker Compose file is being 

## Setting up / Upgrading

See the [installation guide][install-guide] on installing BitwardenRS on either Divio or Railway, as you choose.

[install-guide]: SETUP.md

Ypu can even follow the setup guide in an cloud environment like Gitpod. Just hit the button below, and you can fire up the terminal and follow along without ever needing to install anything in your local machine

[![Gitpod ready-to-code](https://img.shields.io/badge/Gitpod-ready--to--code-blue?logo=gitpod)](https://gitpod.io/#https://github.com/AndreiJirohHaliliDev2006/bitwardenrs-on-divio)

## Features

Most of PaaS platforms like Divio and Railway have support for Dockerfiles, so you should be probably fine.

## Limitations

Since we're running our own Vaultwarden instance in an Docker container, there is no persistent storage on most PaaS services. Thus, attachments are disabled and any changes to the configuration through the admin panel will be lost on deploy.

## FAQ

* Can't receive the verification link into my inbox or mostly
fall to spam/junk. Now what?
  * Configure SMTP settings first. See [this docs page](https://github.com/dani-garcia/vaultwarden/wiki/SMTP-configuration) for details.
  * Prefer not to self-host your own mail server? See [this section from the docs](https://github.com/dani-garcia/vaultwarden/wiki/SMTP-configuration#smtp-servers) for options.
* Admin panel is disabled, but I want to get support string or invite users. How?
  * Manual: Set the `ENABLE_ADMIN` into `true`, then use an password generator for the `ADMIN_TOKEN`.
  * Automated: Run `./tools/enable-admin-panel <paas-platform-slug>`
* How do I configure my instance?
  * All environment variables will be treated as configuration of Vaultwarden.
  * When using Divio/Railway/other services that use containers, backup your changes on admin panel as the filesystem don't usually presist on containers.
  because on every deploy, changes are loss.
* I'm logged out after navigating away from the web vault. Hpw do I fix it?
  * Run `tools/generate-rsakey <paas-platform-slug>` to enable persistent RSA key on every website session.
