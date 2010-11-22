# fbapp

A command line interface to your facebook apps

Installing as a gem will make `fbapp` available as a command.

So far you can only do two things:

    fbapp list         # List your facebook apps
    fbapp show         # Show app settings

## Caveats

This will store your facebook email and password unencrypted in ~/.fbapp
TODO: Use `security` to access the Keychain on a Mac.