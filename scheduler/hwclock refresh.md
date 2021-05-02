# WSL2 hardware clock refresh

The WSL2 system clock is suspended when Windows hibernates. The resulting offset causes authentication and checks that rely on time to fail.

## Setup

1. Enable passwordless sudo (both for convenience, and so that we can trigger sudo commands from Powershell without entering a password)
    - If desired you can implement this in a minimum-security fashion for the specific command
    - edit `/etc/sudoers` -> update the last line to read `%sudo ALL=(ALL) NOPASSWD:ALL`
2. Add a task to trigger `wsl --distribution Ubuntu-18.04 -e sudo hwclock -s` at *logon* and *user unlock* (see the task template in this directory, which will need an update for the running user if imported)
    - Run "whether user is logged on or not" to avoid the popup window flicker