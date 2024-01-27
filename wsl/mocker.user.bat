@echo off

wsl -d %DISTRO_NAME% apk add --update dos2unix jq wget zip

wsl -d %DISTRO_NAME% mkdir -p /home/%DISTRO_USER%/.docker 
wsl -d %DISTRO_NAME% cp wsl/config.json /home/%DISTRO_USER%/.docker
wsl -d %DISTRO_NAME% chmod 0640 /home/%DISTRO_USER%/.docker/config.json

wsl -d %DISTRO_NAME% cp wsl/banner /etc/motd; dos2unix -q /etc/motd; chmod 0644 /etc/motd
wsl -d %DISTRO_NAME% /bin/echo cat /etc/motd ^>^> /etc/profile

wsl -d %DISTRO_NAME% cp wsl/.bash_aliases /home/%DISTRO_USER%/; chmod 0640 /home/%DISTRO_USER%/.bash_aliases

wsl -d %DISTRO_NAME% cp wsl/.bashrc /home/%DISTRO_USER%/; chmod 0640 /home/%DISTRO_USER%/.bashrc

wsl -d %DISTRO_NAME% cp wsl/.profile /home/%DISTRO_USER%/; chmod 0640 /home/%DISTRO_USER%/.profile

wsl -d %DISTRO_NAME% -u %DISTRO_USER% mkdir -p /home/%DISTRO_USER%/documents

wsl -d %DISTRO_NAME% -u %DISTRO_USER% mkdir -p /home/%DISTRO_USER%/projects

wsl -d %DISTRO_NAME% chown -R %DISTRO_USER%:%DISTRO_USER% /home/%DISTRO_USER%
