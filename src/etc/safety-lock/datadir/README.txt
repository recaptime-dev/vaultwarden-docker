This directory contains the code needed to allow normal startup process
in the code.key file of this directory, assuming that you don't set
the I_REALLY_WANT_VOLATILE_STORAGE variable to true and mounted any Docker
volumes to the datadir for Vaultwarden (currently not implemented in the
shell script yet).

The code is generated using the following command:

    openssl rand -hex 365

Please do not rely using that file for senstive operations, since this is
publicly distributed alongside the code and the built OCI image.