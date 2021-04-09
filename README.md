# BitwardenRS on Divio/Railway

Run [bitwarden_rs](https://github.com/dani-garcia/bitwarden_rs) on Divio.
This may also work on Railway, too.

Based on official bitwarden_rs docker image and also hard-forked
from the original [bitwardenrs_heroku](https://github.com/std2main/bitwardenrs_heroku)
repo, I added customized scripts to setup and manage in both
Divio and Railway enviroments.

## Goal
* Deploy a reliable bitwarden for free as easy as possible.
  * Deploying: Requires basic command line skills. You'll be guided through the setup guide.
  * Maintainance: Almost zero. 
  * As more functions as budget support
    1. Essentials and backups: In Divio, you jave up to 3 backups for 30 days. You can always manually backup if you want.
    2. Icons: They'll always pulled on startup for new deploys. You can optionally disable it in the `bwrs-startup` file.
    3. TODO: Realtime syncing cross multiple devices. This requires Nginx setup chaos.
    4. TODO: Attachments. Since containers don't usually keep files once destoryed, we may consider doing some AWS S3 magic.

## Setting up / Upgrading

See the [installation guide][install-guide] on installing BitwardenRS on
either Divio or Railway, as you choose.

[install-guide]: SETUP.md

Ypu can even follow the setup guide in an cloud environment like Gitpod. Just hit the button below,
and you can fire up the terminal and follow along without ever needing to install anything in your
local machine

[![Gitpod ready-to-code](https://img.shields.io/badge/Gitpod-ready--to--code-blue?logo=gitpod)](https://gitpod.io/#https://github.com/AndreiJirohHaliliDev2006/bitwardenrs-on-divio)

## Why Divio/Railway

* Bitwarden_rs is a lightweight service that able to run on
Divio and Railway without even paying a penny.

## Features

### For Divio

* 1 GB of Postgres DB storage for free developer plan
* 512 MB of RAM (when used over 200% aka 1 GB, things go brrr)

### For Railway

* Specs unknown yet, will update once pricing has been updated.
  * But Railway should also fine too.

## Limitations
* No persistent storage on Divio and Railway (untested)
  * No Attachments.
  * Admin Panel changes will be lost on deploy.

## FAQ
* Can't receive the verification link into my inbox or mostly
fall to spam/junk. Now what?
  * Configure SMTP settings first. See `docs/smtp-setup.md` for details.
  * Prefer not to self-host your own mail server? See [this section from the official BWRS docs](https://github.com/dani-garcia/bitwarden_rs/wiki/SMTP-configuration#smtp-servers) for options.
* Admin panel is disabled. Now what?
  * Manual: Set the `ENABLE_ADMIN` into `true`, then use an password generator for the `ADMIN_TOKEN`.
  * Automated: Run `./tools/enable-admin-panel [divio|railway]`
* How do I configure my instance?
  * All environment variables will be treated as configuration of bitwarden_rs.
  * When using Divio/Railway/other services that use containers, backup your changes on admin panel as the filesystem don't usually presist on containers.
  because on every deploy, changes are loss.
* I'm logged out after navigating away from the web vault. Hpw do I fix it?
  * Run `tools/generate-rsakey [divio|railway]` to enable persistent RSA key on every website session.
