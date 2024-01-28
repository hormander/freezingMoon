@echo off

set REMOTE_NAME_OUTPUT=alpine-minirootfs-3.19.0-x86_64.tar.gz

set REMOTE_NAME=https://dl-cdn.alpinelinux.org/alpine/v3.19/releases/x86_64/%REMOTE_NAME_OUTPUT%

set GID=10000

if not exist %TEMP%/%REMOTE_NAME_OUTPUT% (
echo Downloading %REMOTE_NAME% ...
curl %REMOTE_NAME% -s --ssl-no-revoke -o %TEMP%/%REMOTE_NAME_OUTPUT%
)

wsl --import %DISTRO_NAME% %TEMP% %TEMP%/%REMOTE_NAME_OUTPUT%

rem
rem Install packages
rem

wsl -d %DISTRO_NAME% apk add --update --no-cache busybox-openrc busybox-suid shadow shadow-uidmap
wsl -d %DISTRO_NAME% apk add --update --no-cache cgroup-tools docker docker-compose openrc 
wsl -d %DISTRO_NAME% apk add --update --no-cache bash curl su-exec sudo

rem
rem Add user
rem
wsl -d %DISTRO_NAME% addgroup -S %DISTRO_USER% -g %GID%; adduser --disabled-password -S %DISTRO_USER% -G %DISTRO_USER% -u %GID% -s /bin/bash --gecos ""
wsl -d %DISTRO_NAME% addgroup %DISTRO_USER% docker

rem
rem Enable sudo without password
rem

wsl -d %DISTRO_NAME% /bin/echo "%DISTRO_USER% ALL=(ALL) NOPASSWD: ALL" ^> /etc/sudoers.d/%DISTRO_USER%
wsl -d %DISTRO_NAME% chmod 0440 /etc/sudoers.d/%DISTRO_USER%

rem
rem Docker stuff
rem

wsl -d %DISTRO_NAME% rc-update add docker default
wsl -d %DISTRO_NAME% mkdir /run/openrc; touch /run/openrc/softlevel
wsl -d %DISTRO_NAME% /bin/echo rc_cgroup_mode=\"unified\" ^>^> /etc/rc.conf

wsl -d %DISTRO_NAME% /bin/echo %DISTRO_USER%:100000:65536 ^>^> /etc/subuid
wsl -d %DISTRO_NAME% /bin/echo %DISTRO_USER%:100000:65536 ^>^> /etc/subgid

wsl -d %DISTRO_NAME% /bin/echo auto lo ^> /etc/network/interfaces
wsl -d %DISTRO_NAME% /bin/echo iface lo inet loopback ^>^> /etc/network/interfaces

wsl -d %DISTRO_NAME% /bin/echo [boot] ^> /etc/wsl.conf; /bin/echo command=\"openrc default\" ^>^> /etc/wsl.conf
wsl -d %DISTRO_NAME% /bin/echo [user] ^>^> /etc/wsl.conf; /bin/echo default=%DISTRO_USER% ^>^> /etc/wsl.conf
