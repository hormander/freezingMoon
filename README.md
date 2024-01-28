# Freezing Moon

This is a simple batch script for installing docker on windows (just docker without anything).

It works over WSL (alpine distro)

## Install

Download the project (unzip it if you need) and run the command:

mocker.install.bat

and following the instructions.

Open a new terminal and run the command:

wsl -d (YOUR DISTRO NAME)

Now, open a new Windows Command Prompt and run the command:

docker info (or docker ps)

Now you have a full docker environment runs on your computer

## Uninstall

Run the command:

mocker.uninstall.bat